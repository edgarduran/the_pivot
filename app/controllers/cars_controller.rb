class CarsController < ApplicationController
  def index
    @cars = Car.all

    # if params[:search]
    #   @cars = Car.search(params[:search])
    # else
    #   @cars = Car.all
    # end
  end

  def show
    car = Car.find(params[:id])
    redirect_to store_car_path(car.id, store: car.store.slug)
  end
end
