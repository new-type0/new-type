class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @addresses = current_customer.addresses
    @addresses = Address.all
    @address = Address.new
  end

  def create
    @address = current_customer.addresses.new(address_params)
    if @address.save
      redirect_to public_addresses_path, notice: '登録完了しました。'
    else
      flash.now[:alert] = '登録に失敗しました。'
      @addresses = current_customer.addresses
      render 'index'
    end
  end


  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to public_addresses_path, notice: '更新に成功しました。'
    else
      render 'edit'
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to public_addresses_path, notice: '削除完了しました。'
  end


  private

  def address_params
    params.require(:address).permit(:name, :address, :postal_code, :customer_id)
  end
end
