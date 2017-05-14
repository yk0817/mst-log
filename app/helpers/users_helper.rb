module UsersHelper
  def link_display(url)
    url.html_safe unless url.nil? 
  end
  
  def boosted?(boost)
    "<i class=\"fa fa-retweet fa-2\"></i>".html_safe if boost == 1
  end
  
  def date_comprise
  end
  
  def have_instance_account?(instance,current_user)
    if CrawlState.where(:instance => instance ,:user_id => current_user.id).exists?
      CrawlState.find_by(:instance => instance,:user_id => current_user.id).instance_user_name
    else
      ""
    end
  end
  
end
