class UsersController < ApplicationController
  before_action :set_user, only: %i[index show]
  before_action :test_set_user, only: %i[index]
  def index
    @toots = Toot.all
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
