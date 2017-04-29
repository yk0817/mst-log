# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170429212826) do

  create_table "toots", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "toot_id"
    t.string "user_id"
    t.string "toot_display_name"
    t.string "toot_username"
    t.text "toot_text"
    t.string "toot_reblogged"
    t.string "toot_instance"
    t.string "toot_link_url"
    t.date "toot_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "tweet_nickname", null: false
    t.integer "tweet_user_id", null: false
    t.string "tweet_screen_name", null: false
    t.string "tweet_background_image"
    t.string "tweet_normal_image", null: false
    t.string "tweet_small_image", null: false
    t.string "tweet_place"
    t.integer "tweet_followed_count"
    t.integer "tweet_following_count"
    t.text "tweet_self_introduce", null: false
    t.string "website_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
