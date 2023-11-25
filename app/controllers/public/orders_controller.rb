class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def confirm
    @order = Order.new(order_params)

    if params[:order][:address_option] == "0"
      @order.shipping_postal_code = current_customer.postal_code
      @order.shipping_address = current_customer.address
      @order.shipping_name = current_customer.last_name + current_customer.family_name

    elsif params[:order][:address_option] == "1"
      ship = Address.find(params[:order][:address_id])
      @order.shipping_postal_code = ship.postal_code
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
    @cart_items = current_customer.cart_items.all
    @order.save

    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item.id
      @order_detail.order_id = @order.id
      @order_detail.amount = cart_item.amount
      @order_detail.tax_included_price = cart_item.item.tax_included_price
      @order_detail.production_status = 0
      @order_detail.save
    end

    current_customer.cart_items.destroy_all
    redirect_to public_orders_thanks_path

  end


  def thanks
  end

  def index
     @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
     @order_detail = OrderDetail.where(@order)

  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)

    # Calculate subtotal
    @subtotal = @order_details.sum { |order_detail| order_detail.amount * order_detail.tax_included_price }

    # Set postage
    @order.postage = 800
  end

private
  def order_params
    params.require(:order).permit(:customer_id, :postage, :shipping_name, :shipping_address, :shipping_postal_code, :payment_method, :billing_amount, :order_status, :address_option)

  end


end
