require 'rails_helper'

RSpec.describe "Properties", type: :request do

=begin
  Coordinates used for comparison are lat: 52.5329014, lng: 13.407021
  property1: 52.5329014, 13.407021
  property2: 52.5354224, 13.4009056
  property3: 52.523728, 13.3814719
  property4: 52.5236285, 13.3853228
  property5: 52.5236285, 12.3853228
=end
  properties = [ 
    {offer_type: 'sell', property_type: 'apartment', zip_code: "10119", city: "Berlin", street: "Choriner Straße",  house_number: "11", lng: 13.407021, lat: 52.5329014, construction_year: 1997, number_of_rooms: 0.3e1, currency: "eur", price: 0.35e6},
    {offer_type: 'sell', property_type: 'apartment', zip_code: "10119", city: "Berlin", street: "Choriner Straße",  house_number: "11", lng: 13.4009056, lat: 52.5354224, construction_year: 1997, number_of_rooms: 0.3e1, currency: "eur", price: 0.35e6},
    {offer_type: 'sell', property_type: 'apartment', zip_code: "10119", city: "Berlin", street: "Choriner Straße",  house_number: "11", lng: 13.3814719, lat: 52.523728, construction_year: 1997, number_of_rooms: 0.3e1, currency: "eur", price: 0.35e6},
    {offer_type: 'sell', property_type: 'apartment', zip_code: "10119", city: "Berlin", street: "Choriner Straße",  house_number: "11", lng: 13.3853228, lat: 52.5236285, construction_year: 1997, number_of_rooms: 0.3e1, currency: "eur", price: 0.35e6},
    {offer_type: 'sell', property_type: 'apartment', zip_code: "10119", city: "Berlin", street: "Choriner Straße",  house_number: "11", lng: 12.3853228, lat: 52.5236285, construction_year: 1997, number_of_rooms: 0.3e1, currency: "eur", price: 0.35e6}
  ]
  before do 
    Property.create(properties)
  end

  describe "GET /index" do
    context 'when params are valid' do
      it 'returns all properties within 5km radius of the given location' do
        get properties_path, params: {
          lat: 52.5329014,
          lng: 13.407021,
          by_offer_type: 'sell',
          by_property_type: 'apartment'
        } 
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body).count).to be(4)
      end
    end

    context 'when params are valid but there are no properties withing the 5km radius' do
      it 'returns empty json' do
        get properties_path, params: {
          lat: 52.5329014,
          lng: 13.407021,
          by_offer_type: 'rent',
          by_property_type: 'single_family_house'
        } 
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body).count).to be(0)
      end
    end

    context 'when params are missing' do
      it 'returns error messages with 422 error code' do
        get properties_path
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq("errors" => {"by_offer_type"=>["is not included in the list", "can't be blank"], "by_property_type"=>["is not included in the list", "can't be blank"], "lat"=>["is not a number", "can't be blank"], "lng"=>["is not a number", "can't be blank"]})
      end
    end
  end
end
