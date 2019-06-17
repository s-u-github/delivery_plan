class BasesController < ApplicationController
  
  def index
    @bases = Base.all
  end
  
  def new
    @base = Base.new
    @base_first = Base.first
    redirect_to login_basis_path(id: @base_first.id) if @base_first.present?
  end
  
  def create
    @base = Base.new(base_params)
    if @base.save
      flash[:success] = "拠点登録完了"
      redirect_to root_url
    else
      flash[:danger] = "入力が足りません。"
      render 'new'
    end
  end
  
  
  private
 
    def base_params
      params.require(:base).permit(:base_name, :postcode, :address)
    end
  
end
