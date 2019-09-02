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
  
  # 月初を抽出
  def first_day(date)
    !date.nil? ? Date.parse(date) : Date.current.beginning_of_month
  end
  
  # 納品時間の検証
  def delivery_time_invalid? # delivery_time_invalid?は真偽値（true, false）を返す
    delivery_time = true
    daily_params.each do |key, value|
      if value[:absence] == "false"
        if value[:delivery_start].blank? && value[:delivery_finish].blank?
          delivery_time = false
          break
        elsif value[:delivery_start].blank? || value[:delivery_start].blank?
          delivery_time = false
          break # breakは単純に繰り返し処理を中断する。
        elsif value[:delivery_start] > value[:delivery_finish]
          delivery_time = false
          break
        end
      end
    end
    return delivery_time
  end
end
