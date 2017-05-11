namespace :mast do
  
  class MastCrawl
    
    def crawl_db_insert(instance_name)
      CrawlState.where(:crawl_status => 0,:instance => instance_name).find_each(:batch_size => 1) do |instance|
        crawl = MastCrawl.new
        url = "https://#{instance.instance}/@#{instance.instance_user_name}"
        instance.crawl_status = 1 # crawling...
        instance.save 

        begin
          while TRUE
            nokogiri_parse = crawl.crawl(url)
            sleep(1)
            crawl.db_insert(nokogiri_parse,instance.user_id,instance.id,instance.instance)
            next_url = crawl.next_page?(nokogiri_parse)
            unless next_url
              instance.crawl_status = 3 # status 3 finish
              instance.save
              break 
            end
            url = next_url
          end
        rescue => e
          p "crawl_db_insert_error!"
          p e.backtrace
          p e.message
          instance.crawl_status = 2 # 2 error end
          instance.save 
        end
      end
    end
    
    def crawl_db_update(instance_name)
      CrawlState.where(:update_crawl_status => 0,:crawl_status => 3,:instance => instance_name).find_each(:batch_size => 1) do |instance|
        # 最小のtoot_date取得、ブーストは除く
        toot_min_date = Toot.where(:user_id => 1,:crawl_instance_id => 1,:toot_instance => "mstdn.jp").where.not(:toot_reblogged => 1).maximum('toot_date')
        
        crawl = MastCrawl.new
        url = "https://#{instance.instance}/@#{instance.instance_user_name}"
        instance.update_crawl_status = 1 # crawling...
        instance.save 
        # 最初のtoot_dateならbreakし、終了
        begin
          while TRUE
            nokogiri_parse = crawl.crawl(url)
            sleep(1)
            toot_unix_time_array = []
            crawl.db_insert(nokogiri_parse,instance.user_id,instance.id,instance.instance) do 
              nokogiri_parse.css(".entry").each do |parse|
                toot_unix_time_array << Time.parse(parse.css("time")[0].attributes["datetime"].value).to_i  unless parse.at(".fa-retweet") #データとして保存用
              end
            end
            
            toot_scraped_unix_time = toot_unix_time_array.min
            next_url = crawl.next_page?(nokogiri_parse)
            
            if toot_min_date.to_i > toot_scraped_unix_time.to_i
              instance.update_crawl_status = 3 # status 3 finish
              instance.save
              break
            end
            url = next_url
          end
        rescue => e
          p "crawl_db_update_error!"
          p e.backtrace
          p e.message
          instance.update_crawl_status = 2 # 2 error end
          instance.save 
        end
      end
    end
        
    def crawl(url)
      charset = nil
      html = open(url) do |f|
        charset = f.charset
        f.read 
      end
      Nokogiri::HTML.parse(html, nil, charset)
    end
    
    
    def next_page?(nokogiri_parse)
      next_url = nokogiri_parse.css(".next")[0]["href"]  if nokogiri_parse.at(".next")
      next_url = false unless nokogiri_parse.at(".next")
      next_url
    end
    
    def db_insert(nokogiri_body,user_id,crawl_instance_id,instance_name)
      hash_for_db = {}
      hash_for_db[:user_id] = user_id
      hash_for_db[:crawl_instance_id] = crawl_instance_id
      hash_for_db[:instance_name] = instance_name
      nokogiri_body.css(".entry").each do |parse|
        hash = for_db_hash(parse,hash_for_db)
        Toot.find_or_create_by(hash)
      end 
      yield if block_given?
    end
    
    def parse(nokogiri_parse)
      doc = nokogiri_parse    
      doc
    end
    
    def for_db_hash(parse,**hash_for_db)
      hash = {}
      hash[:toot_id] = parse.css(".status__meta > .u-uid")[0].attributes["href"].value.match(/.+\/(\d+)$/).captures[0]
      hash[:toot_username] = parse.css(".display-name > span").text
      hash[:toot_display_name] = parse.css(".display-name > strong").text
      hash[:toot_reblogged] = 1 if parse.at(".fa-retweet") #ブーストは1ブーストじゃない→0
      hash[:toot_display_name] = parse.css(".display-name").to_html
      hash[:toot_link_text] = parse.css(".status__attachments__inner").to_html if parse.at(".status__attachments__inner")
      hash[:toot_date] =  Time.parse(parse.css("time")[0].attributes["datetime"].value) #データとして保存用
      hash[:toot_text] = parse.css("div.e-content").to_html #テキスト本文 面倒なんでタグごとぶっこむ
      hash[:user_id] = hash_for_db[:user_id]
      hash[:crawl_instance_id] = hash_for_db[:crawl_instance_id]
      hash[:toot_instance] = hash_for_db[:instance_name]
      return hash
    end
    
  end
  
  # 新規登録用のクローリング
  task :mastdn_crawl => :environment do
    MastCrawl.new.crawl_db_insert("mstdn.jp")
  end
  
  task :nico_crawl => :environment do
    MastCrawl.new.crawl_db_insert("friends.nico")
  end
  
  task :pawoo_crawl => :environment do
    MastCrawl.new.crawl_db_insert("pawoo.net")
  end
  
  # 更新用DBクローリング
  
  task :mastdn_update_crawl => :environment do
    MastCrawl.new.crawl_db_update("mstdn.jp")
  end
  
  task :nico__update_crawl => :environment do
    MastCrawl.new.crawl_db_update("friends.nico")
  end
  
  task :mastdn_update_crawl => :environment do
    MastCrawl.new.crawl_db_update("pawoo.net")
  end
  
end

__END__
例
`bundle exec rails mast:mastdn_crawl`
