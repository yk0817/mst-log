class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit]
  before_action :set_toot, only: %i[show]
  
  def home
  end
  
  def index
    # 一旦仮置き本来はユーザーIDが入ってきたらrelation入れて億
    @date_counts = Toot.new.toot_week_count(1)
    @user = User.find(1)
  end
  
  def show
    @date_counts = Toot.new.toot_week_count(params[:id])
    @toot_counts = Toot.where(:user_id => params[:id]).count
    @recent_users = User.order('created_at DESC').limit(5)
  end
  
  def edit
    
  end
  
  def new
    @instances = ["mstdn.jp","friends.nico","pawoo.net"]
    @crawl_state = current_user.crawl_states.build
  end
  
  def create #user create 
    user = User.find_or_create_user_auth_hash(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to(user_path)
  end
  
  def instance
    
    # あとでリファ
    p account_params["user_id"]
    hash = {}
    hash[:user_id] = account_params["user_id"].to_i
    hash[:instance] = "mstdn.jp"
    hash[:instance_user_name] = account_params["mstdn.jp"]
    CrawlState.find_or_create_by(hash) unless hash[:instance_user_name].empty?
    hash[:instance] = "friends.nico"
    hash[:instance_user_name] = account_params["friends.nico"]
    CrawlState.find_or_create_by(hash)  unless hash[:instance_user_name].empty?
    hash[:instance] = "pawoo.net"
    hash[:instance_user_name] = account_params["pawoo.net"]
    CrawlState.find_or_create_by(hash) unless hash[:instance_user_name].empty?
    redirect_to(user_path)
  end
  
  
  private
  
  def instatnce_check(instance_name)
    instatnce_name.strip.gsub(/^[@＠]/,"") 
  end
  
  def set_user
    @user = User.find(params[:id]) 
  end
  
  def set_toot
    @toots = @user.toots.page(params[:page]).per(ApplicationController::PER)
  end
  
  def account_params
    # シンボル
    params.permit("user_id","mstdn.jp",'friends.nico','pawoo.net')
  end
  
end
  