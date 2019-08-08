class DailyReportsController < ApplicationController
  
  # 納品開始・終了時間作成
  def delivery_time
    @user = User.find(params[:user_id])
    @article = @user.articles.find(params[:article_id])
    @daily = @article.DailyReports.find_by(day: Date.today)
    
    if @daily.delivery_start.nil?
      @daily.update_attributes(delivery_start: current_time)
      flash[:info] = "納品開始"
    elsif @daily.delivery_finish.nil?
      @daily.update_attributes(delivery_finish: current_time)
      flash[:info] = "納品終了"
    end
    redirect_to plan_list_user_articles_url(user_id: current_user.id)
  end
  
  # 日報作成
  def report_create
    @user = User.find(params[:user_id])
    @articles_delivery = @user.articles.where(plan_check: true).where.not(base_point: true)
    @articles_delivery.each do |article|
      daily = article.DailyReports.find_by(day: Date.today)
      daily.update_attributes(report_name: @user.name)
    end
    # 移動するかどうかの確認をする動作を追加する
    flash[:success] = "成功（一時的に表示している）"
    redirect_to plan_list_user_articles_url(user_id: current_user.id)
  end
  
  # 日報一覧表示
  def daily_index
    @user = User.find(params[:user_id])
    @first_day = first_day(params[:first_day])
    @last_day = @first_day.end_of_month
  end
  
  # 日報詳細・編集
  def daily_show
    @user = User.find(params[:user_id])
    @daily_current= params[:date]
    @dailys = DailyReport.where(day: @daily_current, report_name: @user.name)
    @dailys_title = []
    @dailys_start = []
    @dailys_finish = []
    @dailys_note = []
    @dailys.each do |daily|
      title = Article.find(daily.article_id).title
      @dailys_title.push(title)
      @dailys_start.push(daily.delivery_start)
      @dailys_finish.push(daily.delivery_finish)
      @dailys_note.push(daily.note)
    end
    
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
        report.page.item(:date).value(@daily_current)
        report.page.item(:name).value(@user.name)
        # 行き先
        report.page.item(:delivery1).value(@dailys_title[0])
        report.page.item(:delivery2).value(@dailys_title[1])
        report.page.item(:delivery3).value(@dailys_title[2])
        report.page.item(:delivery4).value(@dailys_title[3])
        report.page.item(:delivery5).value(@dailys_title[4])
        report.page.item(:delivery6).value(@dailys_title[5])
        report.page.item(:delivery7).value(@dailys_title[6])
        report.page.item(:delivery8).value(@dailys_title[7])
        report.page.item(:delivery9).value(@dailys_title[8])
        report.page.item(:delivery10).value(@dailys_title[9])
        # 納品開始時間
        report.page.item(:start1).value(@dailys_start[0].strftime("%H:%M")) if @dailys_start[0].present?
        report.page.item(:start2).value(@dailys_start[1].strftime("%H:%M")) if @dailys_start[1].present?
        report.page.item(:start3).value(@dailys_start[2].strftime("%H:%M")) if @dailys_start[2].present?
        report.page.item(:start4).value(@dailys_start[3].strftime("%H:%M")) if @dailys_start[3].present?
        report.page.item(:start5).value(@dailys_start[4].strftime("%H:%M")) if @dailys_start[4].present?
        report.page.item(:start6).value(@dailys_start[5].strftime("%H:%M")) if @dailys_start[5].present?
        report.page.item(:start7).value(@dailys_start[6].strftime("%H:%M")) if @dailys_start[6].present?
        report.page.item(:start8).value(@dailys_start[7].strftime("%H:%M")) if @dailys_start[7].present?
        report.page.item(:start9).value(@dailys_start[8].strftime("%H:%M")) if @dailys_start[8].present?
        report.page.item(:start10).value(@dailys_start[9].strftime("%H:%M")) if @dailys_start[9].present?
        # 納品終了時間
        report.page.item(:finish1).value(@dailys_finish[0].strftime("%H:%M")) if @dailys_finish[0].present?
        report.page.item(:finish2).value(@dailys_finish[1].strftime("%H:%M")) if @dailys_finish[1].present?
        report.page.item(:finish3).value(@dailys_finish[2].strftime("%H:%M")) if @dailys_finish[2].present?
        report.page.item(:finish4).value(@dailys_finish[3].strftime("%H:%M")) if @dailys_finish[3].present?
        report.page.item(:finish5).value(@dailys_finish[4].strftime("%H:%M")) if @dailys_finish[4].present?
        report.page.item(:finish6).value(@dailys_finish[5].strftime("%H:%M")) if @dailys_finish[5].present?
        report.page.item(:finish7).value(@dailys_finish[6].strftime("%H:%M")) if @dailys_finish[6].present?
        report.page.item(:finish8).value(@dailys_finish[7].strftime("%H:%M")) if @dailys_finish[7].present?
        report.page.item(:finish9).value(@dailys_finish[8].strftime("%H:%M")) if @dailys_finish[8].present?
        report.page.item(:finish10).value(@dailys_finish[9].strftime("%H:%M")) if @dailys_finish[9].present?
        # 備考  
        report.page.item(:note1).value(@dailys_note[0]) if @dailys_note[0].present?
        report.page.item(:note2).value(@dailys_note[1]) if @dailys_note[1].present?
        report.page.item(:note3).value(@dailys_note[2]) if @dailys_note[2].present?
        report.page.item(:note4).value(@dailys_note[3]) if @dailys_note[3].present?
        report.page.item(:note5).value(@dailys_note[4]) if @dailys_note[4].present?
        report.page.item(:note6).value(@dailys_note[5]) if @dailys_note[5].present?
        report.page.item(:note7).value(@dailys_note[6]) if @dailys_note[6].present?
        report.page.item(:note8).value(@dailys_note[7]) if @dailys_note[7].present?
        report.page.item(:note9).value(@dailys_note[8]) if @dailys_note[8].present?
        report.page.item(:note10).value(@dailys_note[9]) if @dailys_note[9].present?
        
        # ブラウザでPDFを表示する
        # disposition: "inline" によりダウンロードではなく表示させている
        send_data(
          report.generate,
          filename:    "日報-#{@user.name}-#{@daily_current}.pdf",
          type:        "application/pdf",
          disposition: "inline"
          )
      end
    end
  end
  
  # 日報更新
  def daily_update
    @user = User.find(params[:user_id])
    @dailys = DailyReport.where(day: params[:date], report_name: @user.name)
    daily_params.each do |key, value|
      daily = DailyReport.find(key)
      daily.update_attributes(delivery_start: value[:delivery_start], delivery_finish: value[:delivery_finish], note: value[:note])
    end
    flash[:success] = "日報を更新しました。"
    redirect_to daily_show_path(date: params[:date])
  end
  
  
  private
  
    def daily_params
      params.permit(daily_reports: [:delivery_start, :delivery_finish, :note])[:daily_reports]
    end
end
