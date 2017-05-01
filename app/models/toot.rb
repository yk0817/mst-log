class Toot < ApplicationRecord
  # select date(toot_date) as date,count(*) from toots where user_id = 1 AND  toot_date BETWEEN (CURDATE() - INTERVAL 7 DAY) AND (CURDATE() + INTERVAL 1 DAY) group by date ;
  scope :week_count, ->(user_id) { where("created_at < ?", time) }
end
