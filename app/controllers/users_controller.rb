class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
      flash[:success] = "Logged in as #{@user.username}"
    else
      flash[:error] = 'Username and password are required.'
      redirect_to new_user_path
    end
  end

  def show
    if current_user
      @user = current_user
    else
      render file: 'public/404'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      if @user.platform_admin?
        redirect_to admin_dashboard_index_path
      else
        redirect_to dashboard_path
        flash[:success] = "You have successfully updated your profile."
      end
    else
      flash.now[:errors] = @user.errors.full_messages.join(', ')
      render :edit
    end
  end

  def profile
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
end
