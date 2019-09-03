module SessionsHelper
  
  # 引数に渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # 現在ログイン中のユーザーを返す (ただし、いる場合のみ)
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
  # 渡されたユーザーがログイン済みユーザーであればtrueを返す
  def current_user?(user)
    user == current_user
  end
  
  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end
  
  # 現在のユーザーをログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  # アクセスしようとしたURLを記憶しておく
  def store_location
    # requestオブジェクトを使いURLを記憶する。後付けif文でGETリクエストのみを記憶するように設定
    session[:forwarding_url] = request.original_url if request.get?
  end
  
end
