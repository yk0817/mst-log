require 'twitter'

namespace :tweet_prof  do
  # ↓ロガー
  ActiveRecord::Base.logger = Logger.new(STDOUT)

  desc "ツイッタープロフ更新" #=> 説明
  task :prof_update => :environment do
    client = Twitter::REST::Client.new do |config|
    
    end

    User.find_each(:batch_size => 1) do |user|
      p user
      begin
        account = client.user(user.tweet_screen_name)
        p account.to_hash
        user.tweet_self_introduce = account.description #プロフィール
        user.save
        sleep(1)
      rescue => e
        pp e.message
        pp e.backtrace
      end
    end
  end
end
