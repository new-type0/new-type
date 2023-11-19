class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.all
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if current_customer
      @address.customer_id = current_customer.id
      @address.save
      redirect_to edit_public_address_path
    else
      render 'index'
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  private

  def address_params
    params.require(:address).permit(:name, :address, :post_code)
  end
end
