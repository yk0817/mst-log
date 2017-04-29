class UsersController < ApplicationController
  before_action :set_user, only: %i[index show]
  def index
    #code
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
