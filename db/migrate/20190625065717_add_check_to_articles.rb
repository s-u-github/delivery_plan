class AddCheckToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :plan_check, :boolean, default: "false"
  end
end
