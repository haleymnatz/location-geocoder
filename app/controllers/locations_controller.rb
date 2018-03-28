class LocationsController < ApplicationController

  def index
    @locations = Location.all
    @location = Location.new
  end

  def new
    # @location = Location.new
    # @location = location.get_location
  end

  def create
    location_search = GeocodingAPI.new(params[:location][:address])
    puts "HERE IS THE ADDRESS: #{params}"
    response = location_search.get_location
    location_dto = LocationDto.new(response["results"][0])
    @location = Location.create(
                              address: location_dto.address,
                              latitude: location_dto.latitude,
                              longitude: location_dto.longitude
                            )
    # @location = location.save
    redirect_to root_path
  end

  private

  def location_params
    params.require(:location).permit(:address, :latitude, :longitude)
  end
end
