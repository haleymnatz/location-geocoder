class GeocodingAPI
  include HTTParty
  base_uri 'https://maps.googleapis.com'

  def initialize(address)
    @options = {
      query: {
        address: address,
        key: ENV['google_geocoding_secret']
      }
    }
  end

  def get_location
    self.class.get('/maps/api/geocode/json?', @options)
  end

end
