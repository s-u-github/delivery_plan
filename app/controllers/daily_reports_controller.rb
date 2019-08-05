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
    
  #   respond_to do |format|
  #   format.html
  #   format.pdf do
  #     render pdf: "sample",   # PDF名
  #           template: "daily_reports/daily_show.html.erb", # viewを対象にする
  #           encoding: "UTF-8" # 日本語に対応させる
  #   end
  # end
    
    # respond_to do |format|
    #   format.html { redirect_to daily_show_path(date: params[:date], format: :pdf, debug: 1) }
    #   format.pdf do
    #       render     pdf: "1.pdf",
    #             encoding: "UTF-8",
    #               layout: "pdf.html.erb",
    #         show_as_html: params[:debug].present? # デバッグ用　パラメタにdebug=1とあるとHTMLを開く
    #   end
    # end
    
    
    respond_to do |format|
      format.html
      format.pdf do
        render      pdf: "日報-#{@user.name}-#{@daily_current}",# PDFファイル名
              encording: "UTF-8",                   # 日本語を使う場合には指定する
                layout: "pdf.html", #レイアウトファイルの指定。views/layoutsが読まれます。
              template: "daily_reports/daily_show.html.erb", #テンプレートファイルの指定。viewsフォルダが読み込まれます。
                 title: "日報-#{@daily_current}"
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
