class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :tweet_nickname
      t.integer :tweet_user_id
      t.string :tweet_screen_name
      t.string :tweet_background_image
      t.string :tweet_normal_image
      t.string :tweet_small_image
      t.string :tweet_place
      t.integer :tweet_followed_count
      t.integer :tweet_following_count
      t.text :tweet_self_introduce
      t.string :website_url
      t.timestamps
    end
  end
end
