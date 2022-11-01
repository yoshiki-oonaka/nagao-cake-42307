class Customer::CustomersController < ApplicationController

  def show
    @customer = crrent_customer
  end


  def edit
    @customer = crrent_customer
  end


  def update
    @customer = Customer.find(params[:id])
      if @customer.update(customer_params)
         flash[:notice] = "会員情報を更新しました。"
         redirect_to customer_customer_path(@customer)
      else
         render :edit
      end
  end


  def check
  end


  def withdraw
    @customer = current_customer
    @customer.update(is_customer_status: true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end


  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number)
  end

end
