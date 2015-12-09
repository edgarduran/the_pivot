class StoresController < ApplicationController
  def new
    @store = Store.new
  end

  def create
    store = Store.new(store_params)
    if store.save
      current_user.store = store
      store.users << current_user
      flash[:notice] = "Your request to create '#{store.name}' has been received"
      redirect_to dashboard_path
    else
      flash[:error] = "Try again."
      redirect_to new_store_path
    end
  end

  def index
    @stores = Store.all
  end

  def edit
    @store = Store.find(params[:id])
  end

  def update
    store = Store.find(params[:id])
    if store.update(store_params)
      flash[:success] = "#{store.name} has been updated"
      redirect_to store_cars_path(store: store.slug)
    else
      flash[:error] = "Please fill out with valid information"
      render :edit
    end
  end

  def validate
    store = Store.find(params[:id])
    if params[:approve] == "yes"
      store.update(approved: true)
    elsif params[:activate] == "yes"
      store.update(activated: true)
    elsif params[:deactivate] == "yes"
      store.update(activated: false)
    else
      store.destroy
    end
    redirect_to stores_path
  end

  private

    def store_params
      params.require(:store).permit(:name, :about)
    end
end
