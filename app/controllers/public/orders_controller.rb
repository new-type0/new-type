class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses.all
  end
  
  def confirm
    @order = Order.new(order_params)
    
    if params[:order][:address_option] == "0"
      @order.shipping_post_code = current_customer.post_code
      @order.shipping_address = current_customer.address
      @order.shipping_name = current_customer.last_name + current_customer.first_name
      
    end
    
  end

  def index
  end

  def show
  end
  
private
  def order_params
    params.require(:order).permit(:postage, :payment_method, :shipping_name, :shipping_address, :shipping_post_code, :customer_id, :total_payment, :status)
    
  end
  
  
end
