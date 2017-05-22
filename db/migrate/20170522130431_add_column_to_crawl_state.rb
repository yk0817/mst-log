class AddColumnToCrawlState < ActiveRecord::Migration[5.1]
  def change
    add_column :crawl_states, :other_instance_num, :integer
  end
end
