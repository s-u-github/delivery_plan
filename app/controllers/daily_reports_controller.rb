class DailyReportsController < ApplicationController
  
  # 納品開始・終了時間作成
  def delivery_time
    @user = User.find(params[:user_id])
    @article = @user.articles.find(params[:article_id])
    @daily = @article.DailyReports.find_by(day: Date.today)
    
    if @daily.delivery_start.nil?
      @daily.update_attributes(delivery_start: current_time)
      flash[:info] = "納品開始"
    elsif @daily.delivery_start.present? && @daily.delivery_finish.nil?
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
    flash[:success] = "日報作成完了"
    redirect_to daily_show_path(date: Date.today)
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
    @dailys = DailyReport.where(day: @daily_current, report_name: @user.name).order('delivery_start')
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
    # pdf表示関連
    pdf_format(@daily_current, @user.name, @dailys_title, @dailys_start, @dailys_finish, @dailys_note)

  end
  
  # 日報更新
  def daily_update
    @user = User.find(params[:user_id])
    @dailys = DailyReport.where(day: params[:date], report_name: @user.name)
    if delivery_time_invalid?
      daily_params.each do |key, value|
        daily = DailyReport.find(key)
        daily.update_attributes(delivery_start: value[:delivery_start], delivery_finish: value[:delivery_finish],
                                absence: value[:absence],note: value[:note])
      end
      flash[:success] = "日報を更新しました。"
      redirect_to daily_show_path(date: params[:date])
    else
      flash[:danger] = "不正な時間入力がありました。再入力して下さい。"
      redirect_to daily_show_path(date: params[:date])
    end
  end
  
  
  private
  
    # 日報更新
    def daily_params
      params.permit(daily_reports: [:delivery_start, :delivery_finish, :note, :absence])[:daily_reports]
    end
end
