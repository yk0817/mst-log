require 'twitter'
require 'dotenv/tasks'


namespace :tweet_prof  do
  # ↓ロガー
  ActiveRecord::Base.logger = Logger.new(STDOUT)

  desc "ツイッタープロフ更新" #=> 説明
  task :prof_update => :environment do
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_KEY']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
    
    User.find_each(:batch_size => 1) do |user|
      begin
        account = client.user(user.tweet_screen_name)
        pp account
        user_info_hash =  account.to_hash
        user.tweet_self_introduce = user_info_hash[:description] #自己紹介
        user.tweet_screen_name = user_info_hash[:screen_name] 
        unless  user_info_hash[:profile_banner_url].nil?
          background_image = user_info_hash[:profile_banner_url] + "/1500x500"
          user.tweet_background_image = background_image
        end
        user.tweet_normal_image = user_info_hash[:profile_image_url].to_s.gsub(/normal/,"400x400")
        user.tweet_small_image = user_info_hash[:profile_image_url]
        
        user.tweet_place = user_info_hash[:profile_location] 
        
        unless user_info_hash[:url].nil?
          user.website_url = user_info_hash[:url]
        end
        user.tweet_followed_count = user_info_hash[:followers_count]
        user.tweet_following_count = user_info_hash[:friends_count] 
        user.save
        sleep(1)
      rescue => e
        pp e.message
        pp e.backtrace
      end
    end
  end
end
