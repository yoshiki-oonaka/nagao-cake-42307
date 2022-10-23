# frozen_string_literal: true

class Customer::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :customer_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  protected

  # 退会の判断
  def customer_state
    ## 処理1　入力済のemailからアカウントを1件取得
    @customer = Customer.find_by(email: params[:customer][:email]
    ## 取得できなかった場合は、メソッドを終了する。
    return if !@customer
    ## 取得したアカウントのパスと入力パスが一致しているかを判断
    if @customer.valid_password?(params[:customer][:password])
    ## 処理内容3
    true && false
    → true
    end
  end
end
