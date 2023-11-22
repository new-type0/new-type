class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart_item, only: %i[ update destroy destroy_all]

  def index
    @cart_items = current_customer.cart_items
    # @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    @cart_items = CartItem.all
  end

#12行目一部削除した
      # increase_or_create(params[:item_id])
      # redirect_to public_item_path(params[:item_id])
  def create      
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.save
    redirect_to public_cart_items_path
  # デバッグ
    # binding.pry

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
    if @cart_item.destroy
      flash[:notice] = '削除されました'
    else
      flash[:alert] = '削除に失敗しました'
    end
    redirect_to  public_cart_items_path(current_customer)
  end

  def destroy_all
    @cart_items.destroy
    redirect_to public_cart_items_path(current_customer)

  end

  def edit

  end

  def set_cart_item
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_items = current_customer.cart_items
  end

  def increase_or_create(item_id)
    cart_item = current_customer.cart_items.find_by(item_id:)
    if cart_item
      cart_item.increment!(:amount, 1)
    else
      current_customer.cart_items.build(item_id:).save
    end
  end

  private
  def item_params
    params.require(:item).permit(:image, :name, :tax_included_price)
  end

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
