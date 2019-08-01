class AddColumnToDailyReports < ActiveRecord::Migration[5.1]
  def change
    add_column :daily_reports, :day, :date
    add_column :daily_reports, :delivery_start, :datetime
    add_column :daily_reports, :delivery_finish, :datetime
    add_column :daily_reports, :note, :string
    add_reference :daily_reports, :article, foreign_key: true
  end
end
