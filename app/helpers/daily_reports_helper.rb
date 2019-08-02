module DailyReportsHelper
  
  # 現在の時間を作成
  def current_time
    Time.new(
        Time.now.year,
        Time.now.month,
        Time.now.day,
        Time.now.hour,
        Time.now.min, 0
        )
  end
  
  #　月初を抽出
  def first_day(date)
    !date.nil? ? Date.parse(date) : Date.current.beginning_of_month
  end
end
