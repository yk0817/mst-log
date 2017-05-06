class ChangeCrawlStatusToCrawlStates < ActiveRecord::Migration[5.1]
  def change
    change_column :crawl_states, :crawl_status, :integer, null: false, default: 0
  end
end
