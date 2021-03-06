class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :toots
  has_many :crawl_states
  accepts_nested_attributes_for :crawl_states


  def self.find_or_create_user_auth_hash(auth_hash)    
    # アカウントはツイッターのみを想定
    # 以下、auth→返ってきたハッシュをDB用に整形
    # pp auth_hash
    tweet_nickname = auth_hash[:info][:nickname]
    tweet_user_id = auth_hash[:uid]
    tweet_screen_name = auth_hash[:info][:name]
    tweet_background_image = auth_hash[:extra][:raw_info][:profile_banner_url] + "/1500x500"
    tweet_small_image = auth_hash[:info][:image]
    tweet_normal_image = auth_hash[:info][:image].to_s.gsub(/normal/,"400x400")
    # tweet_place = auth_hash[:extra][:raw_info][:location]
    # tweet_followed_count = auth_hash[:extra][:raw_info][:followers_count]
    # tweet_following_count = auth_hash[:extra][:raw_info][:friends_count]
    self_introduce = auth_hash[:extra][:raw_info][:description]

    
    User.find_or_create_by(tweet_user_id: tweet_user_id) do |user|
        user.tweet_nickname = tweet_nickname
        user.tweet_user_id = tweet_user_id
        user.tweet_self_introduce = self_introduce
        user.tweet_screen_name = tweet_screen_name
        user.tweet_background_image = tweet_background_image
        user.tweet_small_image = tweet_small_image
        user.tweet_normal_image = tweet_normal_image
        # user.tweet_place = tweet_place
        # user.tweet_followed_count = tweet_followed_count
        # user.tweet_following_count = tweet_following_count
    end
  end
end
