class CrawlState < ApplicationRecord
  belongs_to :user
  has_many  :toots, dependent: :destroy,foreign_key: 'crawl_instance_id'
  
  def self.relate_toot_find_destroy(instance,account_params={})
    hash = hash_for_save_instance(instance,account_params)
    if CrawlState.where(hash).count == 0 && hash[:instance_user_name] != ""
      CrawlState.where(:instance => hash[:instance],:user_id => hash[:user_id]).all.destroy_all
      CrawlState.create(hash)      
    end
  end
  
  def self.hash_for_save_instance(instance,account_params)
    hash = {}
    hash[:user_id] = account_params["user_id"].to_i    
    if instance.to_s.match(/other_instance/)
      hash[:instance] = account_params["#{instance}"]
      unless account_params["#{instance}_domain"].nil?
        hash[:instance] =  account_params["#{instance}_domain"].gsub(/^[@＠]/,"")
        hash[:instance_user_name] = account_params["#{instance}"].gsub(/\s|　/,"")
      end
    else
      hash[:instance] = instance
      hash[:instance_user_name] = account_params["#{instance}"].gsub(/^[@＠]/,"")
    end
    return hash
  end

end
