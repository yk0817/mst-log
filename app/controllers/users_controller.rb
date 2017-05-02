class UsersController < ApplicationController
  before_action :set_user, only: %i[index show]
  before_action :test_set_user, only: %i[index]
  def index
    # 一旦仮置き本来はユーザーIDが入ってきたらrelation入れて億
    @date_counts = Toot.new.toot_week_count(1)
  end
  
  def show
    
  end
  
  private
  
  def set_user
    # @user = User.find(params[:id])
  end
  
  def test_set_user
    @user = User.find(1)
  end
  
end
  