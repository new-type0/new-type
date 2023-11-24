class Admin::OrderDetailsController < ApplicationController
before_action :authenticate_admin!

  
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(production_status: params[:order_detail][:production_status])
    
    order = @order_detail.order
    if params[:order_detail][:production_status] == "production"
      order.update(order_status: "production")      
    end
    
    if is_making_completed(order)
      order.update(order_status: "preparing")
    end
    
    flash[:notice] = "更新に成功しました！"
    redirect_to admin_order_path(@order_detail.order)
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
