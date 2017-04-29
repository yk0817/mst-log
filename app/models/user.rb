class User < ApplicationRecord
  def self.find_or_create_user_auth_hash(auth_hash)    
    # アカウントはツイッターのみを想定
    # 以下、auth→返ってきたハッシュをDB用に整形
    tweet_nickname = auth_hash[:info][:nickname]
    tweet_user_id = auth_hash[:uid]
    tweet_screen_name = 
    tweet_background_image = 
    tweet_small_image = auth_hash[:info][:image]
    tweet_normal_image = auth_hash[:info][:image].to_s.gsub(/normal/,"400x400")
    tweet_place = auth_hash[:extra][:raw_info][:location]
    tweet_followed_count = auth_hash[:extra][:raw_info][:followers_count]
    tweet_following_count = 
    
    User.find_or_create_by(tweet_user_uid: tweet_user_id) do |user|
        
    end
  end
end
