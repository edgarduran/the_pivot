class CartCarsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    car = Car.find(params[:car_id])
    @cart.add_car(car.id)
    session[:cart] = @cart.contents
    flash[:notice] = "You now have #{pluralize(@cart.count_of(car.id), car.model)} in your cart."

    redirect_to cars_path
  end

  def update
    if params[:days].to_i <= 0
      destroy
    else
      @cart.update_days(params[:days], params[:id])
      redirect_to cart_path
    end
  end

  def destroy
    car = Car.find(params[:id].to_i)
    if @cart.remove_cars(params)
      flash[:remove] = "You have removed the car: #{view_context.link_to(car.full_name, store_car_path(car, store: car.store.slug))} from your cart."
    end
    redirect_to cart_path
  end
end
