class LocationsController < ApplicationController
  def show
    @location = Location.find_by_slug(params[:slug])
  end

  # def index
  #   @locations = Location.all
  # end
end
