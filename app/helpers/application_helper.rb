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
  
  def instance_link(user_id,instance_name)
    if CrawlState.where(:user_id => user_id, :instance => instance_name).exists? 
      user = User.find(user_id)
      instance_count = user.crawl_states.where(:instance => instance_name).count 
      account = user.crawl_states.find_by(:instance => instance_name)
      link_to_if(instance_count >= 1 ,image_tag("#{account.instance.to_s}.png",:class=> "instance-icon",:id =>"instance-id"),"https://#{account.instance}/@#{account.instance_user_name}",:class => "#{instance_name}-link")    
    end
  end
  
  def other_instance_link(user_id,instance_name)
    if CrawlState.where(:user_id => user_id, :instance => instance_name).exists? 
      
    end
  end
  
  def saved_toots?(id)
    Toot.where(:user_id => id).exists? && User.where(:id => id).exists?
  end

end

