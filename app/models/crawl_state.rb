class CrawlState < ApplicationRecord
  belongs_to :user
  has_many  :toots, dependent: :destroy,foreign_key: 'crawl_instance_id'
  
  def self.relate_toot_find_destroy(instance,account_params={})
    hash = hash_for_save_instance(instance,account_params)
    # other instanceで既存の
    if instance.match(/other_instance/) && CrawlState.where(:user_id => hash[:user_id],:other_instance_num => hash[:other_instance_num],:instance => hash[:instance],:instance_user_name => hash[:instance_user_name]).count == 0 && hash[:instance_user_name] != ""
      CrawlState.where(:other_instance_num => hash[:other_instance_num],:user_id => hash[:user_id]).all.destroy_all
      CrawlState.create(hash)      
    elsif CrawlState.where(hash).count == 0 && hash[:instance_user_name] != ""
      CrawlState.where(:instance => hash[:instance],:user_id => hash[:user_id]).all.destroy_all
      CrawlState.create(hash)      
    end
  end
  
  def self.hash_for_save_instance(instance,account_params)
    hash = {}
    hash[:user_id] = account_params["user_id"].to_i    
    # インスタンス名も保存する用
    if instance.to_s.match(/other_instance/)
      unless account_params["#{instance}_domain"].nil?
        hash[:instance] =  account_params["#{instance}_domain"].gsub(/^[@＠]/,"")
        hash[:instance_user_name] = account_params["#{instance}"].gsub(/\s|　/,"")
        hash[:other_instance_num] = instance.gsub(/other_instance/,"")
      end
    #メジャーインスタンス用メソッド 
    else
      hash[:instance] = instance
      hash[:instance_user_name] = account_params["#{instance}"].gsub(/^[@＠]/,"")
    end
    return hash
  end
  

end
