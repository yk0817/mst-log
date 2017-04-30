class CreateToots < ActiveRecord::Migration[5.1]
  def change
    create_table :toots do |t|
      t.integer :toot_id, limit: 8
      t.integer  :user_id
      t.string  :toot_display_name
      t.string  :toot_username
      t.text  :toot_text
      t.integer  :toot_reblogged,default: 0
      t.string  :toot_instance
      t.text  :toot_link_text
      t.datetime    :toot_date
      t.timestamps
    end
  end
end