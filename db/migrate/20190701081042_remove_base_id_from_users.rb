class RemoveBaseIdFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :base_id, :index
  end
end
