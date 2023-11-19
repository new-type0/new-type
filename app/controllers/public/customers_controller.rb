class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
    redirect_to public_customer_path(current_customer)
  end

  private
  def customer_params
    params.require(:customer).permit(:family_name, :last_name, :family_name_kana, :last_name_kana, :email, :postal_code, :address, :phone_number)
  end

end
