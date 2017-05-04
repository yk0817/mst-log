class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit]
  before_action :set_toot, only: %i[show]

  
  def index
    # 一旦仮置き本来はユーザーIDが入ってきたらrelation入れて億
    @date_counts = Toot.new.toot_week_count(1)
    @user = User.find(1)
  end
  
  def show
    @date_counts = Toot.new.toot_week_count(1)
  end
  
  def edit
    
  end
  
  def new
    @crawl_state = CrawlState.new
  end
  
  def create
    #メモ 新規登録、インスタンス追加でアクションを変更させておく。
    user = User.find_or_create_user_auth_hash(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to(inde_path)
  end
  

  
  private
  
  def set_user
    @user = User.find(params[:id]) 
  end

  
  def set_toot
    @toots = @user.toots.page(params[:page]).per(ApplicationController::PER)
  end
  
end
  