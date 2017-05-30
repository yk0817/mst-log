require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  
  describe 'GET #index' do
    before do
      # controller_macros.rb内のlogin_userメソッドを呼び出し
      login_user(user)
      
    end
  end
  
  
  it "renders the :index template" do
    p  login_user(user)
  end
end
