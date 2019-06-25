class ArticlesController < ApplicationController
  
  def index
    @user = User.find(params[:user_id])
    @articles = @user.articles.all
    @article = @user.articles.new
  end
  
  def create
    @user = User.find(params[:user_id])
    @article = @user.articles.new(article_params)
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
  
  
  private
  
    def article_params
      params.require(:article).permit(:title, :postcode, :latitude, :longitude, :address, :phone_num)
    end

end
