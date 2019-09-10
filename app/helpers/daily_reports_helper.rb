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
  
  # 発着時間の検証
  def delivery_time_invalid? # delivery_time_invalid?は真偽値（true, false）を返す
    delivery_time = true
    daily_params.each do |key, value|
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
    return delivery_time
  end
  
  # pdf
  def pdf_format(date, name, title, start, finish, note)
    respond_to do |format|
      format.html
      format.pdf do
        
        # Thin ReportsでPDFを作成
        # 先ほどEditorで作ったtlfファイルを読み込む
        report = Thinreports::Report.new(layout: "#{Rails.root}/app/pdfs/daily_report.tlf")
        
         # 1ページ目を開始
        report.start_new_page
        # itemメソッドでtlfファイルのIDを指定し、
        # valueメソッドで値を設定します
        report.page.item(:date).value(date)
        report.page.item(:name).value(name)
        
        # 行き先
        report.page.item(:delivery0).value(title[0])
        report.page.item(:delivery1).value(title[1])
        report.page.item(:delivery2).value(title[2])
        report.page.item(:delivery3).value(title[3])
        report.page.item(:delivery4).value(title[4])
        report.page.item(:delivery5).value(title[5])
        report.page.item(:delivery6).value(title[6])
        report.page.item(:delivery7).value(title[7])
        report.page.item(:delivery8).value(title[8])
        report.page.item(:delivery9).value(title[9])
        report.page.item(:delivery10).value(title[10])
        report.page.item(:delivery11).value(title[11])
        report.page.item(:delivery12).value(title[12])
        report.page.item(:delivery13).value(title[13])
        report.page.item(:delivery14).value(title[14])
        report.page.item(:delivery15).value(title[15])
        report.page.item(:delivery16).value(title[16])
        report.page.item(:delivery17).value(title[17])
        report.page.item(:delivery18).value(title[18])
        report.page.item(:delivery19).value(title[19])
        report.page.item(:delivery20).value(title[20])
        
        # 納品開始時間
        report.page.item(:start0).value(start[0].strftime("%H:%M")) if start[0].present?
        report.page.item(:start1).value(start[1].strftime("%H:%M")) if start[1].present?
        report.page.item(:start2).value(start[2].strftime("%H:%M")) if start[2].present?
        report.page.item(:start3).value(start[3].strftime("%H:%M")) if start[3].present?
        report.page.item(:start4).value(start[4].strftime("%H:%M")) if start[4].present?
        report.page.item(:start5).value(start[5].strftime("%H:%M")) if start[5].present?
        report.page.item(:start6).value(start[6].strftime("%H:%M")) if start[6].present?
        report.page.item(:start7).value(start[7].strftime("%H:%M")) if start[7].present?
        report.page.item(:start8).value(start[8].strftime("%H:%M")) if start[8].present?
        report.page.item(:start9).value(start[9].strftime("%H:%M")) if start[9].present?
        report.page.item(:start10).value(start[10].strftime("%H:%M")) if start[10].present?
        report.page.item(:start11).value(start[11].strftime("%H:%M")) if start[11].present?
        report.page.item(:start12).value(start[12].strftime("%H:%M")) if start[12].present?
        report.page.item(:start13).value(start[13].strftime("%H:%M")) if start[13].present?
        report.page.item(:start14).value(start[14].strftime("%H:%M")) if start[14].present?
        report.page.item(:start15).value(start[15].strftime("%H:%M")) if start[15].present?
        report.page.item(:start16).value(start[16].strftime("%H:%M")) if start[16].present?
        report.page.item(:start17).value(start[17].strftime("%H:%M")) if start[17].present?
        report.page.item(:start18).value(start[18].strftime("%H:%M")) if start[18].present?
        report.page.item(:start19).value(start[19].strftime("%H:%M")) if start[19].present?
        report.page.item(:start20).value(start[20].strftime("%H:%M")) if start[20].present?
        
        # 納品終了時間
        report.page.item(:finish0).value(finish[0].strftime("%H:%M")) if finish[0].present?
        report.page.item(:finish1).value(finish[1].strftime("%H:%M")) if finish[1].present?
        report.page.item(:finish2).value(finish[2].strftime("%H:%M")) if finish[2].present?
        report.page.item(:finish3).value(finish[3].strftime("%H:%M")) if finish[3].present?
        report.page.item(:finish4).value(finish[4].strftime("%H:%M")) if finish[4].present?
        report.page.item(:finish5).value(finish[5].strftime("%H:%M")) if finish[5].present?
        report.page.item(:finish6).value(finish[6].strftime("%H:%M")) if finish[6].present?
        report.page.item(:finish7).value(finish[7].strftime("%H:%M")) if finish[7].present?
        report.page.item(:finish8).value(finish[8].strftime("%H:%M")) if finish[8].present?
        report.page.item(:finish9).value(finish[9].strftime("%H:%M")) if finish[9].present?
        report.page.item(:finish10).value(finish[10].strftime("%H:%M")) if finish[10].present?
        report.page.item(:finish11).value(finish[11].strftime("%H:%M")) if finish[11].present?
        report.page.item(:finish12).value(finish[12].strftime("%H:%M")) if finish[12].present?
        report.page.item(:finish13).value(finish[13].strftime("%H:%M")) if finish[13].present?
        report.page.item(:finish14).value(finish[14].strftime("%H:%M")) if finish[14].present?
        report.page.item(:finish15).value(finish[15].strftime("%H:%M")) if finish[15].present?
        report.page.item(:finish16).value(finish[16].strftime("%H:%M")) if finish[16].present?
        report.page.item(:finish17).value(finish[17].strftime("%H:%M")) if finish[17].present?
        report.page.item(:finish18).value(finish[18].strftime("%H:%M")) if finish[18].present?
        report.page.item(:finish19).value(finish[19].strftime("%H:%M")) if finish[19].present?
        report.page.item(:finish20).value(finish[20].strftime("%H:%M")) if finish[20].present?
        
        # 備考  
        report.page.item(:note0).value(note[0]) if note[0].present?
        report.page.item(:note1).value(note[1]) if note[1].present?
        report.page.item(:note2).value(note[2]) if note[2].present?
        report.page.item(:note3).value(note[3]) if note[3].present?
        report.page.item(:note4).value(note[4]) if note[4].present?
        report.page.item(:note5).value(note[5]) if note[5].present?
        report.page.item(:note6).value(note[6]) if note[6].present?
        report.page.item(:note7).value(note[7]) if note[7].present?
        report.page.item(:note8).value(note[8]) if note[8].present?
        report.page.item(:note9).value(note[9]) if note[9].present?
        report.page.item(:note10).value(note[10]) if note[10].present?
        report.page.item(:note11).value(note[11]) if note[11].present?
        report.page.item(:note12).value(note[12]) if note[12].present?
        report.page.item(:note13).value(note[13]) if note[13].present?
        report.page.item(:note14).value(note[14]) if note[14].present?
        report.page.item(:note15).value(note[15]) if note[15].present?
        report.page.item(:note16).value(note[16]) if note[16].present?
        report.page.item(:note17).value(note[17]) if note[17].present?
        report.page.item(:note18).value(note[18]) if note[18].present?
        report.page.item(:note19).value(note[19]) if note[19].present?
        report.page.item(:note20).value(note[20]) if note[20].present?
        
        # ブラウザでPDFを表示する
        # disposition: "inline" によりダウンロードではなく表示させている
        send_data(
          report.generate,
          filename:    "日報-#{name}-#{date}.pdf",
          type:        "application/pdf",
          disposition: "inline"
          )
        end
      end
  end
end
