class Admin::OrdersController < ApplicationController
before_action :authenticate_admin!

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @customer = @order.customer
    @order_details = @order.order_details
    @order_detail = OrderDetail.find(params[:id])

  end

  def update
    @order = Order.find(params[:id])
    # @order.update(order_params)
    # redirect_to admin_order_path(@order)
    @order_details = @order.order_details
    @order.update(order_params)
    
    if @order.order_status == "payment_confirmation"
      @order_details.update_all(production_status: "waiting")
    end
    # if @order.update(order_params)
    #   @order_details.update_all(production_status:"waiting") if @order.order_status == "1"
    # end
    
    redirect_to admin_order_path(@order)
  end

private
  def order_params
    params.require(:order).permit(:order_status)

  end

end
