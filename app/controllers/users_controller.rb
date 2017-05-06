class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit]
  before_action :set_toot, only: %i[show]
  
  def index
    # 一旦仮置き本来はユーザーIDが入ってきたらrelation入れて億
    @date_counts = Toot.new.toot_week_count(1)
    @user = User.find(1)
  end
  
  def show
    @date_counts = Toot.new.toot_week_count(params[:id])
    @recent_users = User.order('created_at DESC').limit(5)
  end
  
  def edit
    
  end
  
  def new
    @instances = ["mstdn.jp","friends.nico","Pawoo"]
    @crawl_state = current_user.crawl_states.build
  end
  
  def create #user create 
    user = User.find_or_create_user_auth_hash(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to(user_path)
  end
  
  def instance
    redirect_to(user_path)
  end
  
  
  private
  
  def set_user
    @user = User.find(params[:id]) 
  end

  
  def set_toot
    @toots = @user.toots.page(params[:page]).per(ApplicationController::PER)
  end
  
end
  