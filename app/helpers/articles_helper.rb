module ArticlesHelper
  
  # 拠点情報があるかどうか
  def bese_point_present?
    @user = User.find(current_user.id)
    @articles = @user.articles.where(base_point: true)
    @articles.present?
  end
  

end
