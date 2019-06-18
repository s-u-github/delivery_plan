class BasesController < ApplicationController
  
  def index
    @bases = Base.all
    @base = Base.new
  end
  
  def new
    @base = Base.new
  end
  
  def create
    @bases = Base.all
    @base = Base.new(base_params)
    if @base.save
      flash[:success] = "拠点登録完了"
      redirect_to bases_path
    else
      flash.now[:danger] = "入力が足りません。"
      render 'index'
    end
  end
  
  def edit
    @base = Base.find(params[:id])
  end
  
  def update
    @base = Base.find(params[:id])
    if @base.update_attributes(base_params)
      flash[:success] = "拠点情報を更新しました。"
      redirect_to bases_url
    else
      flash.now[:danger] = "ダメです。"
      render 'index'
    end
  end
  
  def destroy
    @base = Base.find(params[:id])
    @base.destroy
    flash[:success] = "削除しました。"
    redirect_to bases_path
  end
  
  private
 
    def base_params
      params.require(:base).permit(:base_name, :postcode, :address, :base_phone_num)
    end
  
end
