class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = current_customer
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(is_active: true)
    redirect_to public_customers_my_page_path(current_customer)
  end

  def confirm
    @customer = current_customer
  end

  def unsubscribe
    @customer = Customer.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private
  def customer_params
    params.require(:customer).permit(:family_name, :last_name, :family_name_kana, :last_name_kana, :email, :postal_code, :address, :phone_number)
  end

end
