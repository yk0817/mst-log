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

ActiveRecord::Schema.define(version: 20170519021015) do

  create_table "crawl_states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer "user_id"
    t.string "instance"
    t.integer "crawl_status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "instance_user_name"
    t.integer "update_crawl_status", default: 0
    t.integer "other_instance_num"
  end

  create_table "toots", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "toot_id"
    t.integer "user_id"
    t.string "toot_display_name"
    t.string "toot_username"
    t.text "toot_text"
    t.integer "toot_reblogged", default: 0
    t.string "toot_instance"
    t.text "toot_link_text"
    t.datetime "toot_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "crawl_instance_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "tweet_nickname"
    t.integer "tweet_user_id"
    t.string "tweet_screen_name"
    t.string "tweet_background_image"
    t.string "tweet_normal_image"
    t.string "tweet_small_image"
    t.string "tweet_place"
    t.integer "tweet_followed_count"
    t.integer "tweet_following_count"
    t.text "tweet_self_introduce"
    t.string "website_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
