class LocationsController < ApplicationController

  def index
    @locations = Location.all
    @location = Location.new
  end

  def create
    # Use httparty class to make api call to geocoding api
    api_response = api_call
    puts "called controller"
    if api_response["results"].empty?
      flash[:notice] = "No results were found for the address you submitted.
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

  def api_call
    # Use httparty class to make api call
    location_search = GeocodingAPI.new(address_formatter)
    api_response = location_search.get_location
  end

  def address_formatter
    shared = params[:location][:address]
    "#{shared[:street_address]}, #{shared[:city]},
    #{shared[:state]}, #{shared[:zip_code]}"
  end
end
