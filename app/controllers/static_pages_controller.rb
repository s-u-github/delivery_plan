class StaticPagesController < ApplicationController
  def home
  end
  
  def create
    @base = Base.new(base_params)
    if @base.save
      flash[:success] = "拠点登録完了"
      redirect_to root_url
    else
      flash[:danger] = "入力が足りません。"
      render 'home'
    end
  end
  
  
  private
 
    def base_params
      params.require(:base).permit(:base_name, :postcode, :address, :base_phone_num)
    end
    
end
