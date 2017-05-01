module UsersHelper
  def link_display(url)
    url.html_safe unless url.nil? 
  end
end
