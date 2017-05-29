class AddColumn2ToCrawlState < ActiveRecord::Migration[5.1]
  def change
    add_column :crawl_states, :picture_danger_flag, :integer
  end
end
