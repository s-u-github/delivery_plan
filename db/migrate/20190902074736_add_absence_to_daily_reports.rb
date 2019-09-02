class AddAbsenceToDailyReports < ActiveRecord::Migration[5.1]
  def change
    add_column :daily_reports, :absence, :boolean, default: "false"
  end
end
