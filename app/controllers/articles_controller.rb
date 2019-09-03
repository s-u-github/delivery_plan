class ArticlesController < ApplicationController
  # ログイン済みでなければ実行できない
  before_action :logged_in_user, only: []
  # 正しいユーザーでなければ実行できない
  before_action :correct_user,   only: [:index, :create, :update, :destroy, :base_new, :base_create,
                                        :base_edit, :base_update, :base_info, :delivery_plan, :plan_list]


  # 顧客一覧
  def index
    @user = User.find(params[:user_id])
    @articles = @user.articles.where.not(base_point: true)
    @article = @user.articles.new
  end
  
  # 顧客登録
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
      else
        flash[:danger] = "登録に失敗しました。"
      end
      redirect_to user_articles_url
    end
  end
  
  # 顧客更新
  def update
    @user = User.find(params[:user_id])
    @article = @user.articles.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:success] = "登録情報を更新しました。"
    else
      flash[:danger] = "更新に失敗しました。。"
    end
      redirect_to user_articles_url
  end
  
  # 顧客削除
  def destroy
    @user = User.find(params[:user_id])
    @article = @user.articles.find(params[:id])
    @article.destroy
    flash[:success] = "削除しました。"
    redirect_to user_articles_url
  end
  
  # 拠点情報新規登録
  def base_new
    @user = User.find(params[:user_id])
    @article = @user.articles.new
  end
  
  # 拠点情報新規作成
  def base_create
    @user = User.find(params[:user_id])
    @article = @user.articles.build(article_params)
    if @article.update_attributes(base_point: true, plan_check: true)
      flash[:success] = "登録完了"
      redirect_to base_info_user_articles_url
    else
      render 'base_new'
    end
  end
  
  # 拠点情報編集
  def base_edit
    @user = User.find(params[:user_id])
    @article = @user.articles.find_by(base_point: true, plan_check: true)
  end
  
  # 拠点情報更新
  def base_update
    @user = User.find(params[:user_id])
    @article = @user.articles.find_by(base_point: true, plan_check: true)
    if @article.update_attributes(article_params)
      flash[:success] = "編集完了"
      redirect_to base_info_user_articles_url
    else
      render 'base_edit'
    end
  end
  
  # 拠点情報
  def base_info
    @user = User.find(params[:user_id])
    @article = @user.articles.find_by(base_point: true, plan_check: true)
  end

  # 配送計画作成ページ
  def delivery_plan
    @user = User.find(params[:user_id])
    @articles = @user.articles.where.not(base_point: true)
  end
  
  # 配送計画作成
  def plan_create
    @user = User.find(params[:user_id])
    @articles = @user.articles.where.not(base_point: true)
    i = 0
    plan_create_params.each do |key, value|
      if value[:plan_check] = true
        i += 1
      end
    end
    
    if params[:commit] == "作成"
      if i <= 20
        plan_create_params.each do |key, value|
          article = Article.find(key)
          article.update_attributes(plan_check: value[:plan_check])
        end
        flash[:success] = "配送計画作成完了"
        redirect_to plan_list_user_articles_path(current_user.id, first_day: Date.today)
      else
        flash[:danger] = "配送先は20箇所までが最大です。"
        redirect_to delivery_plan_user_articles_path(current_user.id)
      end
    elsif params[:commit] == "リセット"
      @articles.update_all(plan_check: false)
      redirect_to delivery_plan_user_articles_path(current_user.id)
    end
  end
  
  # 配送計画リスト
  def plan_list
      @user = User.find(params[:user_id])
      @articles_all = @user.articles.all
      @articles = @user.articles.where(plan_check: true)
      @articles_count = @user.articles.where(plan_check: true).count
      @article_base = @user.articles.find_by(base_point: true)
      @articles_delivery = @user.articles.where(plan_check: true, base_point: false)
    
    if @article_base == nil
      flash[:danger] = "拠点情報がありません。はじめに拠点情報を登録してください。"
      redirect_to base_new_user_articles_url(current_user.id)
    elsif @articles_delivery.empty?
      flash[:info] = "配送計画を作成して下さい。"
      redirect_to delivery_plan_user_articles_url(current_user.id)
    else
      # javascriptで使用
      gon.base = @article_base
      gon.count = @articles_count
      gon.articles = @articles
      latitude = [@article_base.latitude]
      longitude = [@article_base.longitude]
      address = []
      title = []
      
      @articles_delivery.each do |article|
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

    # beforeアクション
    
    # ログイン済みユーザーか確認
    def logged_in_user
      unless logged_in?
        # sessionsヘルパーメソッド
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
    
    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:user_id])
      # 後付けif文の構成と一緒で、条件式がfalseの場合のみ、冒頭のコードが実行される、current_user?はsessonヘルパーメソッド
        redirect_to(root_url) unless current_user?(@user)
    end
end
