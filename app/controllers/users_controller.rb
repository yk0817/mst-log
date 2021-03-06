class UsersController < ApplicationController
  before_action :set_user, only: %i[new show edit]
  before_action :set_toot, only: %i[show]
  
  def home
  end
  
  def index
    # 一旦仮置き本来はユーザーIDが入ってきたらrelation入れて億
    @date_counts = Toot.new.toot_week_count(1)
    @user = User.find(1)
  end
  
  def show
    if Toot.where(:user_id => params[:id]).count > 0
      @date_counts = Toot.new.toot_week_count(params[:id].to_i)
      @toot_counts = Toot.where(:user_id => params[:id]).count
    end
    @recent_users = ActiveRecord::Base.connection.select_all("SELECT * FROM crawl_states LIMIT 8;")
  end
  
  def edit
    
  end
  
  def new
    @instances = ["mstdn.jp","friends.nico","pawoo.net","other_instance1","other_instance2"]
    @crawl_state = tweet_current_user.crawl_states.build  if tweet_current_user
    @crawl_state = current_user.crawl_states.build  if current_user
  end
  
  def create #twitter user create 
    user = User.find_or_create_user_auth_hash(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to(user_path)
  end
  
  def instance
    # p account_params
    %w(mstdn.jp friends.nico pawoo.net other_instance1 other_instance2).each do |instance|
      CrawlState.relate_toot_find_destroy(instance,account_params)
    end
    redirect_to(user_path,:notice => '登録完了です。データ収集完了までしばらくお待ち下さい。')
  end
  
  
  private
  
  def instatnce_check(instance_name)
    instatnce_name.strip.gsub(/^[@＠]/,"") 
  end
  
  def set_user
    if !session[:user_id].nil? 
      @user = User.find(params[:id]) 
    elsif !current_user.nil?
      @user = current_user 
    else
      redirect_to(home_path, :notice => 'ログインして下さい。')
    end
  end
  
  def set_toot
    if Toot.where(:user_id => params[:id]).exists? && User.where(:id => params[:id]).exists?
      @toots = Toot.where(:user_id => params[:id]).order("toot_date DESC").page(params[:page]).per(ApplicationController::PER)
    end
  end
  
  def account_params
    # シンボル
    params.permit("user_id","mstdn.jp",'friends.nico','pawoo.net','other_instance1','other_instance2','other_instance1_domain','other_instance2_domain')
  end
  
end
  