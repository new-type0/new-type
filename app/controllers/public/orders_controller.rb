class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def new
    @order = Order.new
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
    
    @cart_items = current_customer.cart_items.all
    
  end
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    
    current_customer.cart_items.each do |cart_item|
      @ordered_item = OrderDetail.new
      @ordered_item.order_id = @order.id
      @ordered_item.item_id = cart_item.item_id
      @ordered_item.quantity = cart_item.quantity
      @ordered_item.tax_included_price = cart_item.item.tax_included_price
      @ordered_item.save
    end
    
    current_customer.cat_items.destroy_all?
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
