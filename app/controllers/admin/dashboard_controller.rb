class Admin::DashboardController < Admin::BaseController
  def index
    @user = current_user
    @orders = Order.all
  end

  def show
    @orders = Order.where(current_status: params[:id])
  end
end
