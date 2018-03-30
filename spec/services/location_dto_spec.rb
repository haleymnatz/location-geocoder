require 'rails_helper'
file = File.read('spec/red_fern_restaurant.json')
data_hash = JSON.parse(file)['results'][0]

RSpec.describe LocationDto do
  subject(:location_dto) { LocationDto.new(data_hash)}

  it 'creates an object with the location\'s formatted address' do
    expect(location_dto.address).to eq(data_hash["formatted_address"])
  end

  it 'creates an object with the location\'s latitude' do
    expect(location_dto.latitude).to eq(
      data_hash["geometry"]["location"]["lat"])
  end

  it 'creates an object with the location\'s latitude' do
    expect(location_dto.longitude).to eq(
      data_hash["geometry"]["location"]["lng"])
  end

  describe 'get_default' do
    it 'returns the desired value when the key is present' do
      expect(location_dto.get_default(data_hash, 'formatted_address')).to eq(
        data_hash["formatted_address"]
      )
    end

    it 'returns the default value when the key is not present' do
      expect(location_dto.get_default(data_hash, 'fake')).to eq(nil)
    end

  end
end
