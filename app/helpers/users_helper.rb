module UsersHelper
  def link_display(url)
    url.html_safe unless url.nil? 
  end
  
  def boosted?(boost)
    "<i class=\"fa fa-retweet fa-2\"></i>".html_safe if boost == 1
  end
  
  
  def have_instance_account?(instance,current_user)
    if CrawlState.where(:instance => instance ,:user_id => current_user.id).exists?
      CrawlState.find_by(:instance => instance,:user_id => current_user.id).instance_user_name
    else
      ""
    end
  end
  
  def image_instance(toot)
    if toot.toot_instance.match(/^mstdn\.jp$|^pawoo\.net$|^friends\.nico$/)
      image_tag("#{toot.toot_instance}.png",:class => "instance-image")
    else
      image_tag("other_instance.png",:class => "instance-image")
    end
  end
  
  def toot_count_sort_instance(instance,user_id)
    Toot.where(:toot_instance => instance,:user_id => user_id).count  
  end
  
  
end
