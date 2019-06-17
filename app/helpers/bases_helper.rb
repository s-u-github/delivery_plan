module BasesHelper
  
  # 拠点の登録が１件以上あるか
  def base_data_presence?
    unless Base.first.present?
      flash[:info] = "拠点を入力してください。"
      redirect_to root_url
    end
  end
  
end
