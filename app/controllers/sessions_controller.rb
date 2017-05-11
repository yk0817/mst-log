class SessionsController < ApplicationController
  def create
    # ログイン処理する。
    user = User.find_or_create_user_auth_hash(request.env['omniauth.auth'])
    session[:user_id] = user.id
    # redirect処理→、更新フラグがある場合とルート変更したい
    redirect_to(user_path(current_user.id))
  end
  
  def destroy
    reset_session
    redirect_to(home_path)
  end
  
end
