class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  PER = 10
  PER.freeze
  
  helper_method :tweet_current_user,:twitter_logged_in?
  
  def tweets_logged_in?
    !!session[:user_id]
  end
  
  def tweet_current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end
  
  def authenticate
    return if logged_in?
    redirect_to(users_path,alert: 'ログインして下さい')
  end
  
end
