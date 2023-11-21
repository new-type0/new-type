class Public::OrdersController < ApplicationController
  def new
  end

  def index
     @orders = Order.where(member_id: current_member.id).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_details= OrderDetail.where(order_id: @order.id)
  end
end
