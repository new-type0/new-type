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

  def index
  end

  def show
  end

private
  def order_params
    params.require(:order).permit(:customer_id, :postage, :shipping_name, :shipping_address, :shipping_postal_code, :payment_method, :billing_amount, :order_status, :address_option)

  end


end
