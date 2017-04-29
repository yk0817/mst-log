class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :tweet_nickname,null:false
      t.integer :tweet_user_id,null:false
      t.string :tweet_screen_name,null:false
      t.string :tweet_background_image,null:false
      t.string :tweet_normal_image,null:false
      t.string :tweet_small_image,null:false
      t.string :tweet_place,null:false
      t.integer :tweet_followed_count,null:false
      t.integer :tweet_following_count,null:false
      t.string :tweet_place,null:false
      t.text :tweet_self_introduce,null:false
      t.string :website_url,null:false
      t.timestamps
    end
  end
end
