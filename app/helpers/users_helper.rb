module UsersHelper
  def link_display(url)
    url.html_safe unless url.nil? 
  end
  
  def boosted?(boost)
    "<i class=\"fa fa-retweet fa-2\"></i>".html_safe if boost == 1
  end
  
  def date_comprise
  end
  
end
