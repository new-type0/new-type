class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_address, only: [:edit, :update, :destroy]

  def index
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def create
    @address = current_customer.addresses.build(address_params)
    if @address.save
      redirect_to public_addresses_path, notice: '登録完了しました。'
    else
      flash.now[:alert] = '登録に失敗しました。'
      @addresses = current_customer.addresses
      render 'index'
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to public_addresses_path, notice: '更新に成功しました。'
    else
      render 'edit'
    end
  end

  def destroy
    @address.destroy
    redirect_to public_addresses_path, notice: '削除完了しました。'
  end

  private

  def set_address
    @address = current_customer.addresses.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:name, :address, :postal_code, :customer_id)
  end
end