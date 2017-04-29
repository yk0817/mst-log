class CreateCrawlStates < ActiveRecord::Migration[5.1]
  def change
    create_table :crawl_states do |t|
      t.integer  :user_id
      t.string  :instance
      t.integer  :crawl_status
      t.timestamps
    end
  end
end
