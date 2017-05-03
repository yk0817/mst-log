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
  
end
