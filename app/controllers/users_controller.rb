class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
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
  
  def show
    @user = User.find(params[:id])
  end
  
  
  
  private
  
  def users_params
    params.require(:user).permit(:name, :email, :phone_num, :password, :password_confirmation)
  end
  
end
