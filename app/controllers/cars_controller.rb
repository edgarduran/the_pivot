class CarsController < ApplicationController
  def index
    @cars = Car.all
    if params[:search]
      @cars = Car.search(params[:search])
    else
      @cars = Car.all
    end
  end

  def show
    @car = Car.find(params[:id])
    @categories = Category.all
  end

  private

  def car_params
    params.require(:car).permit(:make, :model, :year, :daily_price, :weekly_price, :description, :image)
  end
end
