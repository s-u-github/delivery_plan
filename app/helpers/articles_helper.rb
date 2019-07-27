module ArticlesHelper
  
  def article_invalid?
    articles = true
    plan_create_params.each do |id, item|
      if item[:plan_check] == "true"
        next # nextは繰り返し処理の中で呼び出されると、その後の処理をスキップしつつ、繰り返し処理自体は続行。
      end
    end
    return articles
  end
  
  # 拠点情報があるかどうか
  def bese_point_present?
    @user = User.find(current_user.id)
    @articles = @user.articles.where(base_point: true)
    @articles.present?
  end
  

end
