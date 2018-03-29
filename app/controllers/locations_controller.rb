class LocationsController < ApplicationController

  def index
    @locations = Location.all
    @location = Location.new
  end

  def create
    location_search = GeocodingAPI.new(address_formatter)
    api_response = location_search.get_location
    if api_response["results"].empty?
      flash[:notice] = "There was a problem with the address you submitted.
      Please try another address."
    else
      location_dto = LocationDto.new(api_response["results"][0])
      Location.create(
                      address: location_dto.address,
                      latitude: location_dto.latitude,
                      longitude: location_dto.longitude
                     )
    end
    redirect_to root_path
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    redirect_to root_path
  end

  private

  def location_params
    params.require(:location).permit(:address, :latitude, :longitude)
  end

  def address_formatter
    firsts = params[:location][:address]
    "#{firsts[:street_address]}, #{firsts[:city]},
    #{firsts[:state]}, #{firsts[:zip_code]}"
  end
end
