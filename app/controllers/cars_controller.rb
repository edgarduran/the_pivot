class CarsController < ApplicationController
  def index
    @cars = Car.all

    # if params[:search]
    #   @cars = Car.search(params[:search])
    # else
    #   @cars = Car.all
    # end
  end
end
