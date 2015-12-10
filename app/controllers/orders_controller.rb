class OrdersController < ApplicationController
  def index
    if current_user
      @orders = current_user.orders
    end
  end

  def show
    if current_user.platform_admin?
      @order_data = Order.find(params[:id]).orders_hash
    elsif current_user.store_admin?
      @order_data = Order.find(params[:id]).orders_hash
    else
      @order_data = current_user.orders.find(params[:id]).orders_hash
    end
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

end
