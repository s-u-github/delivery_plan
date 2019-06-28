class AddDayPlanToArticles < ActiveRecord::Migration[5.1]
  def change
    add_reference :articles, :day_plan, foreign_key: true
  end
end
