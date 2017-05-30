require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!


RSpec.configure do |c|
  c.include UsersHelper
  c.include Devise::TestHelpers, type: :controller
end

RSpec.describe "user_helper" do
  
  before do
    sign_in user_instance
  end
  
  it "test_boosted?" do
    expect(boosted?(1)).to eq "<i class=\"fa fa-retweet fa-2\"></i>"
  end
  
  # 未完成です。
  it "test_have_instance_account?" do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    sign_in user
    p sign_in user
    # allow(helper).to receive(:current_user).and_return(user)
    # expect(helper.have_instance_account?("mstdn.jp",current_user)).to eq "Bis_dri_drei"
  end
  
  
end
  