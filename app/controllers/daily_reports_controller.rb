class DailyReportsController < ApplicationController
  
  def delivery_time
    @user = User.find(params[:user_id])
    @article = @user.articles.find(params[:article_id])
    @daily = @article.DailyReports.find_by(day: Date.today)
    
    if @daily.delivery_start.nil?
      @daily.update_attributes(delivery_start: Time.current)
      flash[:info] = "納品開始"
    elsif @daily.delivery_finish.nil?
      @daily.update_attributes(delivery_finish: Time.current)
      flash[:info] = "納品終了"
    end
    redirect_to plan_list_url(user_id: current_user.id)
      
    
  end
end
