class AddColumnToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :postcode, :string
    add_column :articles, :phone_num, :string
    add_reference :articles, :user, foreign_key: true
  end
end
