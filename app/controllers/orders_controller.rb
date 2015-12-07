class OrdersController < ApplicationController
  def index
    if current_user
      @orders = current_user.orders
    end
  end

  def show
    @order_data = current_user.orders.find(params[:id]).orders_hash
  end

  def create
    if session[:cart].nil? || session[:cart] == {}
      flash[:no_items] = "There's nothing in your cart."
      redirect_to cars_path
    elsif current_user && session[:cart]
      current_user.set_order(session[:cart])
      session.delete(:cart)
      flash[:success] = 'Order was successfully placed'
      redirect_to orders_path
    else
      flash[:login] = 'You must be logged in to check out'
      redirect_to login_path
    end
  end

  def update
    current_user.orders.find(params[:id]).update_attributes(current_status: params[:order_status])
    redirect_to admin_dashboard_index_path
  end
end
