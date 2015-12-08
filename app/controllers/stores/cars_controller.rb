class Stores::CarsController < ApplicationController
  def index
    @cars = Car.where(:slug == params[:store])
  end

  def new
    store = Store.find_by(slug: params[:store])
    @car  = store.cars.new
    @store_slug = params[:store]
  end

  def create
    @location = Location.find_by(params[:location_id])
    @store    = Store.find_by(slug: params[:store])
    @car = Car.new(car_params)
    if @car.save
      @store.cars << @car
      @location.cars << @car
      redirect_to store_cars_path(store: @car.store.slug)
      flash[:success] = "Car #{@car.year} #{@car.make} #{@car.model} has been added to store"
    else
      render :new
    end
  end

  def show
    @car = Car.find(params[:id])
  end

  private

  def car_params
    params.require(:car).permit(:make, :model, :year, :description, :daily_price, :image)
  end
end
