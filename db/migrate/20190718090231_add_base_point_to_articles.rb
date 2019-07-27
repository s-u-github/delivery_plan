class AddBasePointToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :base_point, :boolean, default: "false"
  end
end
