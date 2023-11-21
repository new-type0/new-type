class Public::AddressesController < ApplicationController

  def index
    @addresses = Address.all
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.customer_id == current_customer.id
      @address.save
      @addresses = Address.all
      redirect_to edit_public_address_path(@address)
    else
      @addresses = Address.all
      render 'index'
    end
  end



  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to edit_public_address_path(@address), notice: '更新に成功しました'
    else
      render 'edit'
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to public_addresses_path, notice: '削除完了しました'
  end


  private

  def address_params
    params.require(:address).permit(:name, :address, :post_code)
  end
end
