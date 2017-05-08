class CrawlState < ApplicationRecord
  belongs_to :user
  has_many  :toots, dependent: :destroy,foreign_key: 'crawl_instance_id'

end
