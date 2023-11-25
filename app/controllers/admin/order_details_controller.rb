class Admin::OrderDetailsController < ApplicationController
before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    # @order_details = @order.order_details.all
    
    @order_detail.update(order_detail_params)
    if @order_detail.production_status == "production"
      @order.update(order_status: 2)
    elsif @order.order_details.count == @order.order_details.where(production_status: "completed").count
      @order.update(order_status: 3)
    end
  
    redirect_to admin_order_path(@order_detail.order)
    
    # is_updated = true
    # if @order_detail.update(order_detail_params)
    #   @order.update(order_status: "2") if @order_detail.production_status == "2"
    #   @order_details.each do |order_detail|
    #     if order_detail.production_status != "3"
    #       is_updated = false
    #     end
    #   end
    #   @order.update(status: "3") if is_updated
    # end

    flash[:notice] = "更新に成功しました！"

  end

private
  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end

  def is_making_completed(order)
    order.order_details.each do |order_detail|
      if order_detail.production_status != 'completed'
        return false
      end
    end
    return true
  end

end
