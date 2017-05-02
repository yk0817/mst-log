class Toot < ApplicationRecord
  
    
  def toot_week_count(*num)
    
sql=<<EOS
  select date(toot_date) as date,count(*) as count from toots where user_id = #{num.first}
  AND  toot_date BETWEEN (CURDATE() - INTERVAL 21 DAY)
  AND (CURDATE() + INTERVAL 1 DAY) group by date 
EOS
  
    ActiveRecord::Base.connection.select_all(sql).to_hash
  end

end
