class Admin::OrdersController < ApplicationController

  def index
    @order = Order.all
  end


  def show
    @order = find.find(params[:id])
    @order_detas = @order.order_detas
  end


  def update
    @order = Order.find(params[:id])
    @order_detas = @order.order_detas
    if @order.update(order_params)
      flash[:notice] = "注文情報が更新されました。"
        if @order.order_status == "入金確認"
           oeder_detas.update.all(making_status: "制作待ち")
        end
      redirect_to admins_order_path(order.id)
    end
  end


  private

  def order_params
    params.require(:order).permit(:order_status)
  end
end
