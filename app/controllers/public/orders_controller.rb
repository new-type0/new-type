class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = Address.all
  end

  def confirm
    @order = Order.new(order_params)

    if params[:order][:address_option] == "0"
      @order.shipping_postal_code = current_customer.postal_code
      @order.shipping_address = current_customer.address
      @order.shipping_name = current_customer.last_name + current_customer.family_name

    elsif params[:order][:address_option] == "1"
      ship = Address.find(params[:order][:customer_id])
      @order.shipping_postal_code = ship.post_code
      @order.shipping_address = ship.address
      @order.shipping_name = ship.name

    elsif params[:order][:address_option] == "2"
      @order.shipping_postal_code = params[:order][:shipping_postal_code]
      @order.shipping_address = params[:order][:shipping_address]
      @order.shipping_name = params[:order][:shipping_name]

    else
      render 'new'
    end
    
    # @cart_items = current_customer.cart_items
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @order_new = Order.new
    render 'confirm'
    
  end
  
  def create
    @order = Order.new(order_params)
    @order.save
    @cart_items = current_customer.cart_items.all
    
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item_id
      @order_detail.order_id = @order_id
      @order_detail.amount = cart_item.amount
      @order_detail.tax_included_price = cart_item.item.tax_included_price
      @order_detail.production_status = 1
      @order_detail.save
    end
    
    @cart_items.destroy_all
    redirect_to public_orders_thanks_path

  end
  
  
  def thanks
  end

  def index
     @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_details= OrderDetail.where(order_id: @order.id)
  end

private
  def order_params
    params.require(:order).permit(:customer_id, :postage, :shipping_name, :shipping_address, :shipping_postal_code, :payment_method, :billing_amount, :order_status, :address_option)

  end


end
