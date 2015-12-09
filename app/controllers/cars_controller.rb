class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def destroy
    car = Car.find(params[:id])
    car.destroy
    flash[:deleted] = 'You have removed the car.'
    redirect_to cars_path
  end

  def show
    car = Car.find(params[:id])
    redirect_to store_car_path(car.id, store: car.store.slug)
  end
end
