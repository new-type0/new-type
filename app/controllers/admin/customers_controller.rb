class Admin::CustomersController < ApplicationController
before_action :authenticate_admin!

  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
    redirect_to admin_customer_path(customer)
  end

  private
  def customer_params
    params.require(:customer).permit(:family_name, :last_name, :family_name_kana, :last_name_kana, :email, :postal_code, :address, :phone_number)
  end

end
