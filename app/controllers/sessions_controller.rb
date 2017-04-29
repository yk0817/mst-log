class SessionsController < ApplicationController
  def create
    # ログイン処理する。
    user = User.find_or_create_user_auth_hash(request.env['omniauth.auth'])
    # session_data修正
    
    # redirect処理→、更新フラグがある場合とルート変更する。
  end
  
  def destroy
    
  end
end
