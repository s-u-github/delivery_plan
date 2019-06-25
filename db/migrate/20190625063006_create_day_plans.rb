class CreateDayPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :day_plans do |t|
      t.date :date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
