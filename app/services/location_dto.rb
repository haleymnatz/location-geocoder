# DTO = data transfer object
class LocationDto
  attr_accessor :address, :latitude, :longitude

  def initialize(json_object)
    self.address = get_default(json_object, "formatted_address")
    self.latitude = get_default(json_object["geometry"]["location"], "lat")
    self.longitude = get_default(json_object["geometry"]["location"], "lng")
  end

  def get_default(obj, key, default = nil)
    obj.include?(key) ? obj[key] : default
  end
end
