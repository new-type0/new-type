class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart_item, only: %i[ create update destroy destroy_all]

  def index
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

#12行目一部削除した
  def create
      if @cart_item
        @cart_item.amount += params[:amount].to_i
        @cart_item.save
        redirect_to public_cart_items_path(current_customer)
      else
        cart_item = CartItem.new(cart_item_params)
        cart_item.customer_id = current_customer.id
        cart_item.save
        redirect_to public_cart_items_path(current_customer)
      end
  end

  def update

    if @cart_item.update(amount: params[:amount].to_i)
      flash[:notice] = '更新されました'
    else
      flash[:alert] = '更新に失敗しました'
    end
    redirect_to  public_cart_items_path(current_customer)

  end

  def destroy
    @delete_cart_item = CartItem.find(params[:id])
    if @delete_cart_item.destroy
      flash[:notice] = '削除されました'
    else
      flash[:alert] = '削除に失敗しました'
    end
    redirect_to  public_cart_items_path(current_customer)
  end

  def destroy_all
    @cart_items = current_customer.cart_items.all
    @cart_items.destroy_all
    redirect_to public_cart_items_path(current_customer)

  end

  def edit

  end

  def set_cart_item
    @cart_item = current_customer.cart_items.find_by(item_id: params[:item_id])
  end

  # def increase_or_create(item_id)
  #   cart_item = current_customer.cart_items.find_by(item_id:)
  #   if cart_item
  #     cart_item.increment!(:amount, 1)
  #   else
  #     current_customer.cart_items.build(item_id:).save
  #   end
  # end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end


end
