class UsersController < ApplicationController
  # ログイン済みでなければ実行できない
  before_action :logged_in_user, only: []
  # 正しいユーザーでなければ実行できない
  before_action :correct_user,   only: [:show]
  
  # ユーザー登録ページ
  def new
    @user = User.new
  end
  
  # ユーザー登録
  def create
    @user = User.new(users_params)
    if @user.save
      flash[:success] = "ユーザーを新規登録完了しました。"
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end
  
  # ユーザー編集
  def edit
    @user = User.find(current_user.id)
  end
  
  # ユーザー更新
  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(users_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to user_path(current_user.id)
    end
    
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  
  
  private
  
    def users_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
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
      @user = User.find(params[:id])
      # 後付けif文の構成と一緒で、条件式がfalseの場合のみ、冒頭のコードが実行される、current_user?はsessonヘルパーメソッド
        redirect_to(root_url) unless current_user?(@user)
    end
  
end
