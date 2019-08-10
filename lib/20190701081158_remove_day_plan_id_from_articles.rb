class RemoveDayPlanIdFromArticles < ActiveRecord::Migration[5.1]
  def change
    remove_column :articles, :day_plan_id, :index
  end
end
