namespace :mast do
  
  class MatsCrawl
    
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
        
        
        crawl = MastCrawl.new
        url = "https://#{instance.instance}/@#{instance.instance_user_name}"
        instance.update_crawl_status = 1 # crawling...
        instance.save 
        
        # 最初のtoot_dateならbreakし、終了

        
      end
    end
    
    
    
    private 
    
    def crawl(url)
      charset = nil
      html = open(url) do |f|
        charset = f.charset
        f.read 
      end
      Nokogiri::HTML.parse(html, nil, charset)
    end
    
    def parse(nokogiri_parse)
      doc = nokogiri_parse    
      doc
    end
    
    def next_page?(nokogiri_parse)
      next_url = nokogiri_parse.css(".next")[0]["href"]  if nokogiri_parse.at(".next")
      next_url = false unless nokogiri_parse.at(".next")
      next_url
    end
    
    def db_insert(nokogiri_body,user_id,crawl_instance_id,instance_name)
      nokogiri_body.css(".entry").each do |parse|
        hash = {}
        hash[:toot_id] = parse.css(".status__meta > .u-uid")[0].attributes["href"].value.match(/.+\/(\d+)$/).captures[0]
        hash[:toot_username] = parse.css(".display-name > span").text
        hash[:toot_display_name] = parse.css(".display-name > strong").text
        hash[:toot_reblogged] = 1 if parse.at(".fa-retweet") #ブーストは1ブーストじゃない→0
        hash[:toot_display_name] = parse.css(".display-name").to_html
        hash[:toot_link_text] = parse.css(".status__attachments__inner").to_html if parse.at(".status__attachments__inner")
        hash[:toot_date] =  Time.parse(parse.css("time")[0].attributes["datetime"].value) #データとして保存用
        hash[:toot_text] = parse.css("div.e-content").to_html #テキスト本文 面倒なんでタグごとぶっこむ
        hash[:user_id] = user_id
        hash[:crawl_instance_id] = crawl_instance_id
        hash[:toot_instance] = instance_name
        Toot.find_or_create_by(hash)
      end
    end
    
    def alread_db_saved?
      
    end
    
  end
  
  # 一つのアカウントで作成
  task :mastdn_crawl => :environment do
    MastCrawl.new.crawl_db_insert("")
  end
  
  # 更新ロジックを作成しておく

end