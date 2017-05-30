require 'rails_helper'

RSpec.configure do |c|
  c.include ApplicationHelper
end


# RSpec.describe Test do
#   describe "Test" do
#     it "test" do
#       expect(test_method).to eq 'test'
#     end
#   end
# end

RSpec.describe "an example group" do
  it "has access to the helper methods defined in the module" do
    expect(help).to be(:available)
  end
  
  it "link_url_short" do
    url = "https://wwww.yahoo.co.jp"
    p link_url_short(url)
    expect(link_url_short(url)).to eq "<a href=\"https://wwww.yahoo.co.jp\">wwww.yahoo.co.jp</a>"
  end
end