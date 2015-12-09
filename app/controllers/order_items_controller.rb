class OrderItemsController < ApplicationController
  def update
    order_item = OrderItem.find(params[:id])
    order_item.order.update(current_status: params[:current_status])
    redirect_to "/#{params[:store_slug]}/dashboard/#{params[:store_id]}"
  end
end
