class HomeController < ApplicationController
  def home
    @featured_car = Car.current_featured
  end
end
