class Customer::ItemsController < ApplicationController

  def index
    @genre = Genre.all
    @item = Item.all
  end


  def show
    @item = Item.find(params[:id])
    @genre = Genre.all
    @cart_item = CartItem.new
  end


  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active)
  end

end
