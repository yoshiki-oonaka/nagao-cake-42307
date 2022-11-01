class Customer::AddressesController < ApplicationController

  def index
    @address = Address.new
    @addresses = current_costomer.addresses
  end


  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id

      if @address.save
         flash[:notice] = "配送先を登録しました"
         redirect_to customer_addresses_path
      else
         @address = Address.new
         @addresses = current_costomer.addresses
         render :index
      end
  end

  def destroy
    @address = Address.find(params[:id])
      if @address.destroy
         flash[:notice] = "配送先情報を削除しました"
         redirect_to customer_addresses_path
      end
  end


  def edit
    @address = Address.find(params[:id])
  end


  def update
    @address = Address.find(params[:id])
      if @address.update(address_params)
         flash[:notice] = "配送先情報を更新しました"
         redirect_to customer_addresses_path
      else
         render :edit
      end
  end


  private

  def address_params
    params.require(:customer).permit(:customer_id, :name, :postal_code, :address)
  end
end
