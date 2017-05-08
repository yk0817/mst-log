class AddCrawlStates < ActiveRecord::Migration[5.1]
  def change
    add_column :toots, :crawl_instance_id, :integer
    add_column :crawl_states, :update_crawl_status, :integer, default: 0

  end
end
