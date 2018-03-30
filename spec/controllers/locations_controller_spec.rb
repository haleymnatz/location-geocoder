require 'rails_helper'
file = File.read('spec/red_fern_restaurant.json')
data_hash = JSON.parse(file)['results'][0]

file2 = File.read('spec/invalid_search_results.json')
invalid_hash = JSON.parse(file2)

RSpec.describe LocationsController, type: :controller do

  subject(:location_dto) { LocationDto.new(data_hash)}
  subject(:valid_create) do
    post :create, params: {
      address: location_dto.address,
      latitude: location_dto.latitude,
      longitude: location_dto.longitude
    }
  end

  describe 'index' do
    it 'returns the queries#index page' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'create' do
    context 'when a valid location has been queried' do
      subject(:address) { "283 Oxford St, Rochester, NY" }

      it 'adds the location to the table' do
        allow(controller).to receive(:address_formatter)
          .and_return(address)
        expect{valid_create}.to change(Location, :count).by(1)
      end
    end

    context 'when an invalid location has been queried' do
      subject(:invalid_dto) { LocationDto.new(invalid_hash)}
      subject(:invalid_address) { "BOOYAH, BOOYAHCITY, BG, 99999"}
      subject(:invalid_create) do
        allow(controller).to receive(:api_call).and_return(invalid_hash)
        post :create, params: {}
      end

      it 'does not add the location to the table' do
        # For this case, expectation is different than normal
        # because of control flow used in create action.
        invalid_create
        expect(Location).not_to receive(:create)
      end

      it 'shows a flash message notifying the user' do
        invalid_create
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe 'destroy' do
    subject(:saved_address) do
      Location.create(address: location_dto.address,
                      latitude: location_dto.latitude,
                      longitude: location_dto.longitude)
    end

    it 'destroys the selected location' do
      saved_address
      delete :destroy, params: { id: saved_address.id}
      expect(Location.find_by(id: saved_address.id)).to eq(nil)
    end
  end
end
