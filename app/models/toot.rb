class Toot < ApplicationRecord
  def toot_week_count(*user_id)
    
sql=<<EOS
  select date(toot_date) as date,count(*) as count from toots where user_id = #{user_id.first}
  AND  toot_date BETWEEN (CURDATE() - INTERVAL 21 DAY)
  AND (CURDATE() + INTERVAL 1 DAY) group by date order by date desc LIMIT 7
EOS

    
  end
  
  def user_toot_have_account?(user_id)
    
  end

end
