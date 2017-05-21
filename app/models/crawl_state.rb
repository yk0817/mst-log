class CrawlState < ApplicationRecord
  belongs_to :user
  has_many  :toots, dependent: :destroy,foreign_key: 'crawl_instance_id'
  
  def self.relate_toot_find_destroy(instance,account_params={})
    hash = {}
    
    hash[:user_id] = account_params["user_id"].to_i
    
    p instance
    if instance.to_s.match(/other_instance/)
      p "---"
      hash[:instance] = account_params["#{instance}"]
      unless account_params["#{instance}_name"].nil?
        hash[:instance] =  account_params["#{instance}"].gsub(/\s|　/,"")
        hash[:instance_user_name] = account_params["#{instance}_name"].gsub(/^[@＠]/,"")
      end
    else
      hash[:instance] = instance
      hash[:instance_user_name] = account_params["#{instance}"].gsub(/^[@＠]/,"")
    end
    if CrawlState.where(hash).count == 0 && hash[:instance_user_name] != ""
      CrawlState.where(:instance => hash[:instance],:user_id => hash[:user_id]).all.destroy_all
      CrawlState.create(hash)
    end
  end

end
