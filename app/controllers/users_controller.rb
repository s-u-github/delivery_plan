class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(users_params)
    if @user.save
      flash[:success] = "配送員登録完了しました。"
      redirect_to root_url
    else
      flash[:danger] = "入力に誤りがあります。"
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
