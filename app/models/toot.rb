class Toot < ApplicationRecord
  # select date(toot_date) as date,count(*) from toots where user_id = 1 AND  toot_date BETWEEN (CURDATE() - INTERVAL 7 DAY) AND (CURDATE() + INTERVAL 1 DAY) group by date ;
  # scope :week_count, ->(user_id) { where("created_at < ?", time) }
  
  def toot_week_count(user_id)
    con = ActiveRecord::Base.connection
    sql = <<'EOS'
      select date(toot_date) as date,count(*) from toots where user_id = #{user_id} AND  toot_date
      BETWEEN (CURDATE() - INTERVAL 7 DAY) AND (CURDATE() + INTERVAL 1 DAY) group by date ;
    EOS
    result = con.select_all('SELECT name, email FROM users')
  end

end
