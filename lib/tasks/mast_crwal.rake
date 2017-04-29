namespace :mast do
  
  class MatCrawl
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
      # 次のページ
      if nokogiri_parse.at(".next")
        next_url = nokogiri_parse.css(".next")[0]["href"]
      else
        next_url = false
      end
      return next_url
    end
  end
  
  # スクレイプ保存タスクを書いていく
  task :crawl => :environment do
    
  
  end
end