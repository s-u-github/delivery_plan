class AddReportNameToDailyReports < ActiveRecord::Migration[5.1]
  def change
    add_column :daily_reports, :report_name, :string
  end
end
