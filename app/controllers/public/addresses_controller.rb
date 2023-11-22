class Public::AddressesController < ApplicationController

  def index
    @addresses = Address.all
    @address = Address.new
  end

  def create
    @address = current_customer.addresses.new(address_params)

    if @address.save
      redirect_to public_addresses_path(@address), notice: 'Address created successfully'
    else
      puts "Address creation failed. Errors: #{address.errors.full_messages}"
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
      redirect_to public_addresses_path(@address), notice: '更新に成功しました'
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
    params.require(:address).permit(:name, :address, :postal_code)
  end
end
