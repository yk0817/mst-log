class AddInstanceUserNameToCrawlStates < ActiveRecord::Migration[5.1]
  def change
    add_column :crawl_states, :instance_user_name, :string
  end
end
