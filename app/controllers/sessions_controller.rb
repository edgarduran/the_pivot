class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      if @user.platform_admin?
        redirect_to admin_dashboard_index_path
        flash[:success] = "Logged in as #{@user.username}"
      elsif @user.store_admin?
        redirect_to "/#{@user.store.slug}/dashboard/#{@user.store_id}"
        flash[:success] = "Logged in as #{@user.username}"
      else
        redirect_to @user
        flash[:success] = "Logged in as #{@user.username}"
      end
    else
      flash[:notice] = 'Invalid Login'
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    flash[:notice] = "You have successfully logged out."
    redirect_to login_path
  end
end
