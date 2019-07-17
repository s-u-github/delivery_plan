class ArticlesController < ApplicationController
  
  def index
    @user = User.find(params[:user_id])
    @articles = @user.articles.all
    @article = @user.articles.new
  end
  
  def create
    @user = User.find(params[:user_id])
    @article = @user.articles.build(article_params)
    if @article.save
      flash[:success] = "登録完了"
      redirect_to user_articles_url
    else
      flash.now[:danger] = "入力が足りません。"
      render 'index'
    end
  end
  
  def update
    @user = User.find(params[:user_id])
    @article = @user.articles.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:success] = "登録情報を更新しました。"
      redirect_to user_articles_url
    else
      flash.now[:danger] = "ダメです。"
      render 'index'
    end
  end
  
  def destroy
    @user = User.find(params[:user_id])
    @article = @user.articles.find(params[:id])
    @article.destroy
    flash[:success] = "削除しました。"
    redirect_to user_articles_url
  end
  
  
  def show
    @article = Article.find(1)
    @articles = Article.all
    @hash = Gmaps4rails.build_markers(@articles) do |article, marker|
      marker.lat article.latitude
      marker.lng article.longitude
      marker.infowindow render_to_string( partial: "articles/infowindow",
                                          locals: {article:article} )
    end
  end
  
  def delivery_plan
    @user = User.find(params[:user_id])
    @articles = @user.articles.all
  end
  
  def plan_create
    @user = User.find(params[:user_id])
    if article_invalid?
      plan_create_params.each do |key, value|
      # @items = plan_create_params.keys.each do |id|
        article = Article.find(key)
        article.update_attributes(plan_check: value[:plan_check])
      end
      flash[:success] = "配送計画作成完了"
      redirect_to delivery_plan_url(current_user.id)
    else
      flash[:danger] = "経由地点が規約より多いです。"
      render 'delivery_plan'
    end
  end
  
  def plan_list
    @user = User.find(params[:user_id])
    @articles = @user.articles.where(plan_check: true)
    @articles_count = @user.articles.where(plan_check: true).count
    gon.count = @articles_count
    gon.articles = @articles
    latitude = []
    longitude = []
    @articles.each do |article|
      latitude.push(article.latitude)
      longitude.push(article.longitude)
    end
    gon.latitude = latitude
    gon.longitude = longitude
  end
  
  private
  
    def article_params
      params.require(:article).permit(:title, :postcode, :latitude, :longitude, :address, :phone_num)
    end
    
    def plan_create_params
      params.permit(articles: [:plan_check])[:articles]
    end

end
