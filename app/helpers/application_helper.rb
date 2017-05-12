module ApplicationHelper
  def time_parse(input_date)
    if Time.now.to_i - input_date.to_i < 60 * 60 #1h以内か
      "#{((Time.now.to_i - input_date.to_i)/60).round}分"
    elsif Time.now.to_i - input_date.to_i < 60 * 60 * 24 #1日前か
      "#{((Time.now.to_i - input_date.to_i)/60/60).round}時間"
    else
      input_date.strftime("%m月%d日")
    end
  end
  
  def link_url_short(link_url)
    return link_to("#{link_url.gsub(/https?:\/\//,"")}",link_url)
  end
  
  def instance_link(user,instance_name)
    instance_count = @user.crawl_states.where(:instance => instance_name).count || 0
    account = @user.crawl_states.find_by(:instance => instance_name)
    link_to_if(instance_count >= 1 ,image_tag("#{account.instance.to_s}.png",:class=> "instance-icon"),"https://#{account.instance}/@#{account.instance_user_name}",:class => "#{instance_name}-link")
  end
  


    # <%= link_to_if(@user.website_url,"nico.friends",@user.website_url,:class => "friends-link")%>
end
