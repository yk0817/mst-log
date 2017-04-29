100.times do |i|
  hash = {}
  hash[:tweet_nickname]  = "やまもと"
  hash[:tweet_self_introduce] = "大学→院→会社勤務→学生 空気を読んだ笑いを意識し、日々努力中。 好きなもの 経済学、外国語、MMA、ラジオ、睡眠 興味・関心　メカデザ、管理会計、原価計算、専業主夫 https://t.co/10s3EkaeSC"
  hash[:tweet_user_id]  = 43862026
  hash[:tweet_screen_name]  = "jesushill"
  hash[:tweet_background_image]  = "http://pbs.twimg.com/profile_banners/43862026/1485803542/1500x500"
  hash[:tweet_normal_image]  = "http://pbs.twimg.com/profile_images/1678798093/898040_60070398_400x400.jpg"
  hash[:tweet_small_image]  = "http://pbs.twimg.com/profile_images/1678798093/898040_60070398_normal.jpg"
  hash[:tweet_place]  = "神奈川県藤沢市"
  hash[:tweet_followed_count]  = 100
  hash[:tweet_following_count]  = 200
  hash[:tweet_following_count]  = 30000
  User.create(hash)
end