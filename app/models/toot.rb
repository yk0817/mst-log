class Toot < ApplicationRecord
  def toot_week_count(*user_id)
    
sql=<<EOS
  select date(toot_date) as date,count(*) as count from toots where user_id = #{user_id.first}
  AND  toot_date BETWEEN (CURDATE() - INTERVAL 21 DAY)
  AND (CURDATE() + INTERVAL 1 DAY) group by date order by date desc LIMIT 5
EOS

    ActiveRecord::Base.connection.select_all(sql).to_hash
  end
  
  def toot_count_sort_instance(instance,user_id)
    Toot.where(:instance => instance,:user_id => user_id).count  
  end

end
