class Customer::OrdersController < ApplicationController
  before_action :authenticate_customer!


  def new
    @order = Order.new
    @customer = current_customer
    @addresses = ShippingAddress.where(customer_id: current_customer.id)
  end


  def create
    customer = current_customer
    session[:order] = Order.new
    cart_items = current_customer.cart_items

    sum = 0
    cart_items.each do |cart_item|
      sum += (cart_item.item.price_without_tax * 1.1).floor * cart_item.amount
    end

    session[:order][:postage] = 800
    session[:order][:total_payment] = sum + session[:order][:postage]
    session[:order][:order_status] = 0
    session[:order][:customer_id] = current_customer.id

    session[:order][:payment_method] = params[:method].to_i

    destination = params[:a_method].to_i
      # 自分の住所時
      if destination == 0
        session[:oeder][:postal_code] = customer.postal_code
        session[:order][:address] = customer.address
        session[:order][:name] = customer.last_name + customer.first_name

      # 登録済の住所
        elsif destination == 1
          address = Address.find(params[:address_for_order])
          session[:order][:postal_code] = address.postal_code
          session[:order][:address] = address.address
          session[:order][:name] = address.name

          # 新しい住所
          elsif destination == 2
            session[:new_address] = 2
            session[:order][:postal_code] = params[:postal_code]
            session[:order][:address] = params[:address]
            session[:order][:name] = params[:name]

      end

      # 新しい住所情報がエラーの場合
      if session[:order][:postal_code].presence && session[:order][:address].presence && session[:order][:name].presence
        redirect_to new_customer_order
      else
        redirect_to customer_log_path
      end

  end

  def thanx
    order = Order.new(session[:order])
    order.save

      if session[:new_address]
			  address = current_customer.shipping_addresses.new
			  address.postal_code = order.post_code
			  address.address = order.address
			  address.name = order.name
			  address.save
			  session[:new_address] = nil
			end

			cart_items = current_customer.cart_items
		  cart_items.each do |cart_item|
			order_detas = OrderDetas.new
			order_detas.order_id = order.id
			order_detas.item_id = cart_item.item.id
			order_detas.amount= cart_item.amount
			order_detas.making_status = 0
			order_detas.price = (cart_item.item.price_without_tax * 1.1).floor
			order_detas.save
		end

    cart_items.destroy_all

  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
		@order_detas = @order.order_detas
  end

  private

  def address_params
    params.require(:shipping_address).permit(:customer_id, :postal_code, :name, :address)
  end

  def order_params
    params.require(:order).permit(:customer_id, :postage, :total_payment, :payment_method, :ordr_status, :post_code, :address, :name)
  end

  def order_detas_params
    params.require(:order_detas).permit(:order_id, :item_id, :amount, :making_status, :price)
  end

end
