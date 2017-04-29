class CreateToots < ActiveRecord::Migration[5.1]
  def change
    create_table :toots do |t|
      t.integer :toot_id, limit: 8
      t.string  :user_id
      t.string  :toot_display_name
      t.string  :toot_username
      t.text  :toot_text
      t.string  :toot_reblogged
      t.string  :toot_instance
      t.string  :toot_link_url
      t.date    :toot_date
      t.timestamps
    end
  end
end
