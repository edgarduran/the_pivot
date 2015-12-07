class StoresController < ApplicationController
  def new
    @store = Store.new
  end

  def create
    store = Store.new(store_params)
    if store.save
      current_user.store = store
      flash[:notice] = "Your request to create '#{store.name}' has been received"
      redirect_to user_path(current_user)
    else
      flash[:error] = "Try again."
      redirect_to new_store_path
    end
  end

  private

    def store_params
      params.require(:store).permit(:name)
    end
end
