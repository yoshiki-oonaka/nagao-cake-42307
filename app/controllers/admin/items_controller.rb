class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
  end


  def index
    @item = Item.new
    @items = Item.all
  end


  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)
    else
      flash[:notice] = "入力にエラーがありました。"
      redirect_to new_admin_item_path
    end
  end


  def show
    @item = Item.find(params[:id])
  end


  def edit
    @item = item.find(params[:id])
  end


  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "商品情報を更新しました。"
      redirect_to admin_items_path(@item)
    else
      render :edit
    end
  end


  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active)
  end

end
