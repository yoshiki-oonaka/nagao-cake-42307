class Customer::CartItemsController < ApplicationController
  before_action :authenticate_customer!


  def index
    @cart_items = current_customer
    @total_price = @cart_items.sum{|cart_item|cart_item.item.price_without_tax * cart_item.quantity * 1.1}
  end


  def create
    @cart_item = CartItem.new
    @cart_item.customer_id = current_customer.id
    @cart_item.item_id = params[:item_id]

    if @cart_item.save
       flash[:notice] = "#{@cart_item.item.name}をカートに追加しました"
       redirect_to customer_cart_items_path
    else
       flash[:aleat] = "個数を選択してください"
       redirect_to customer_item_path
    end
  end


  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to customer_cart_items_path
  end


  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash.now[:aleat] = "#{@cart_item.item.name}を削除しました"
    redirect_to customer_cart_items_path
  end


  def all_destroy
    @cart_item = current_customer.cart_items
    @cert_item.destroy_all
    flash[:alert] = "カートの商品を全て削除しました"
  　redirect_to customer_cart_items_path
  end


  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end


end
