class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash[:danger] = "メールアドレスとパスワードが一致しませんでした。"
      redirect_to root_url
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
  
end
