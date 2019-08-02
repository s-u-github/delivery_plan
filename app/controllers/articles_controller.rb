class ArticlesController < ApplicationController
  
  def index
    @user = User.find(params[:user_id])
    @articles = @user.articles.where.not(base_point: true)
    @article = @user.articles.new
  end
  
  def create
    @user = User.find(params[:user_id])
    if params[:commit] == "CSVをインポート"
      if params[:users_file].content_type == "text/csv" # file_field_tagで選択したファイルがCSVファイルかどうか
        registered_count = import_articles # import_usersは下の方にメソッドあり CSVのインポート処理関連
        unless @errors.count == 0
          flash[:danger] = "#{@errors.count}件登録に失敗しました"
        end
        unless registered_count == 0
          flash[:success] = "#{registered_count}件登録しました"
        end
        redirect_to user_articles_url(error_users: @errors)
      else
        flash[:danger] = "CSVファイルのみ有効です"
        redirect_to user_articles_url
      end
    else
      @article = @user.articles.build(article_params)
      if @article.save
        flash[:success] = "登録完了"
        redirect_to user_articles_url
      else
        flash.now[:danger] = "入力が足りません。"
        render 'index'
      end
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
  
  def base_new
    @user = User.find(params[:user_id])
    @article = @user.articles.new
  end
  
  def base_create
    @user = User.find(params[:user_id])
    @article = @user.articles.build(article_params)
    if @article.update_attributes(base_point: true, plan_check: true)
      flash[:success] = "登録完了"
      redirect_to base_info_user_articles_url
    else
      flash.now[:danger] = "入力が足りません。"
      render 'base_new'
    end
  end
  
  def base_edit
    @user = User.find(params[:user_id])
    @article = @user.articles.find_by(base_point: true, plan_check: true)
  end
  
  def base_update
    @user = User.find(params[:user_id])
    @article = @user.articles.find_by(base_point: true, plan_check: true)
    if @article.update_attributes(article_params)
      flash[:success] = "編集完了"
      redirect_to base_info_user_articles_url
    else
      flash.now[:danger] = "入力が足りません。"
      render 'base_edit'
    end
  end
  
  def base_info
    @user = User.find(params[:user_id])
    @article = @user.articles.find_by(base_point: true, plan_check: true)
  end

  
  def delivery_plan
    @user = User.find(params[:user_id])
    @articles = @user.articles.where.not(base_point: true)
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
      redirect_to delivery_plan_user_articles_url(current_user.id)
    else
      flash[:danger] = "経由地点が規約より多いです。"
      render 'delivery_plan'
    end
  end
  
  def plan_list
    @user = User.find(params[:user_id])
    @articles_all = @user.articles.all
    @articles = @user.articles.where(plan_check: true)
    @articles_count = @user.articles.where(plan_check: true).count
    @article_base = @user.articles.find_by(base_point: true)
    @articles_delivery = @user.articles.where(plan_check: true).where.not(base_point: true)
    
    # @article_id = []
    # @articles_delivery.each do |article|
    #   @article_id.push(article.id)
    # end
      
    
    gon.base = @article_base
    gon.count = @articles_count
    gon.articles = @articles
    latitude = []
    longitude = []
    address = []
    title = []
    @articles.each do |article|
      latitude.push(article.latitude)
      longitude.push(article.longitude)
      address.push(article.address)
      title.push(article.title)
    end
    gon.latitude = latitude
    gon.longitude = longitude
    gon.address = address
    gon.title = title
    
    @articles_all.each do |article|
      @first_day = first_day(params[:first_day])
      @last_day = @first_day.end_of_month # 初月の日付を使って月末をインスタンス変数に代
      (@first_day..@last_day).each do |day|
        unless article.DailyReports.any? {|daily| daily.day == day} # unless文なのでfalseの場合、下の処理をする。
          record = article.DailyReports.build(day: day) # Railsの慣習に倣い、あるモデルに関連づいたモデルのデータを生成するのにbuildメソッドを使っている
          record.save
        end
      end
    end
  end
  
  private
  
    def article_params
      params.require(:article).permit(:title, :postcode, :latitude, :longitude, :address, :phone_num)
    end
    
    def plan_create_params
      params.permit(articles: [:plan_check])[:articles]
    end
    
     # CSVインポート
    def import_articles
      # 登録処理前のレコード数
      current_article_count = ::Article.count
      articles = []
      @errors = []
      # windowsで作られたファイルに対応するので、encoding: "SJIS"を付けている
      # headersオプションを使うと、CSVの初めの1行はheaderとして出力の際に無視される (nameなどの属性名部分)
      CSV.foreach(params[:users_file].path, headers: true) do |row| # CSV.foreach # ファイルから一行ずつ読み込み 又、application.rbでrequire 'csv'も必要
        article = Article.new({ title: row["title"], phone_num: row["phone_num"], postcode: row["postcode"], address: row["address"], user_id: current_user.id})
        if article.valid?
          articles << ::Article.new({ title: row["title"], phone_num: row["phone_num"],postcode: row["postcode"], address: row["address"], user_id: current_user.id})
        else
          @errors << article.errors.inspect # inspectメソッドとは、オブジェクトや配列などをわかりやすく文字列で返してくれるメソッド
        end
      end
      # importメソッドでバルクインサートできる(gem 'activerecord-import'が必要)
      ::Article.import(articles)
      # 何レコード登録できたかを返す
      ::Article.count - current_article_count
    end

end
