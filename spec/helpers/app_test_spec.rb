require 'rails_helper'

RSpec.configure do |c|
  c.include ApplicationHelper
end

RSpec.describe "an example group" do
  
  it "link_url_short" do
    url = "https://wwww.yahoo.co.jp"
    expect(link_url_short(url)).to eq "<a href=\"https://wwww.yahoo.co.jp\">wwww.yahoo.co.jp</a>"
  end
  
  it "time_parse" do
    relative_time = Time.parse("2017/5/10 16:53")
    expect(time_parse(relative_time)).to eq "05月10日"
  end
  
  it "saved_toots?" do
    saved_flag = Toot.where(:user_id => 1).exists? && User.where(:id => 1).exists?
    false_flag = Toot.where(:user_id => 100).exists? && User.where(:id => 1).exists?
    expect(saved_flag).to eq true
    expect(false_flag).to eq false

  end
  
  it "test_instance_link" do
    test = link_to_if(true,image_tag("friends.nico.png",:class=> "instance-icon",:id =>"instance-id"),"https://friends.nico/@shinmyc",:class => "friends.nico-link")
    test2 = link_to_if(true,image_tag("other_instance.png",:class=> "instance-icon",:id =>"instance-id"),"https://mstdn.guru/@yoshi_zwa",:class => "other-instance-link")
    expect(instance_link(20,"friends.nico")).to eq test
    expect(instance_link(1,"mstdn.guru")).to eq test2
    
  end
  
  
end
  