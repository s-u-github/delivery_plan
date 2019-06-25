class RemoveNewFromArticles < ActiveRecord::Migration[5.1]
  def change
    remove_column :articles, :new, :string
  end
end
