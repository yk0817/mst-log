class CrawlState < ApplicationRecord
  belongs_to :user
  has_many  :toots, dependent: :destroy,foreign_key: 'crawl_instance_id'
  
  def self.relate_toot_find_destroy(instance,account_params={},hash={})
    hash = {}
    hash[:user_id] = account_params["user_id"].to_i
    hash[:instance] = instance
    hash[:instance_user_name] = account_params["#{instance}"]
    if CrawlState.where(hash).count == 0
      CrawlState.where(:instance => hash[:instance],:user_id => hash[:user_id]).all.destroy_all
      CrawlState.create(hash)
    end
  end
  USER_ERROR = 'アルファベット・数値・アンダーバー(_)で入力してください'

  validates :instance_user_name,
    format: { with: /\A[a-zA-Z0-9_].+/,allow_blank: true,message: USER_ERROR}
  
end
