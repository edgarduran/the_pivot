class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user #,:current_admin?

  before_action :set_cart


  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_permission
    @current_permission ||= PermissionService.new(current_user)
  end

  def set_cart
    @cart = Cart.new(session[:cart])
  end


  # def current_admin?
  #   current_user && current_user.admin?
  # end


  def authorize!
    unless authorized?
      flash[:error] = "You are not authorized"
      redirect_to '/'
    end
  end

  before_action :authorize!

  private
  def authorized?
    current_permission.allow?(params[:controller], params[:action])
  end

end
