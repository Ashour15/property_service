require 'rails_helper'

RSpec.describe Property, type: :model do
  describe "scopes" do
    context 'by_property_type' do
      let!(:property1) { Property.create(property_type: 'apartment', zip_code: 111, city: 'Berlin') }
      let!(:property2) { Property.create(property_type: 'apartment', zip_code: 111, city: 'Berlin') }
      let!(:property3) { Property.create(property_type: 'single_family_house', zip_code: 111, city: 'Berlin') }
      subject { Property.by_property_type('apartment').to_a }
      it { is_expected.to match_array [property1, property2] }
    end

    context 'by_offer_type' do
      let!(:property1) { Property.create(offer_type: 'rent', zip_code: 111, city: 'Berlin') }
      let!(:property2) { Property.create(offer_type: 'rent', zip_code: 111, city: 'Berlin') }
      let!(:property3) { Property.create(offer_type: 'sell', zip_code: 111, city: 'Berlin') }
      subject { Property.by_offer_type('sell').to_a }
      it { is_expected.to match_array [property3] }
    end

    context 'nearest' do
      let!(:property1) { Property.create( lng: 13.407021, lat: 52.5329014, zip_code: 111, city: 'Berlin') }
      let!(:property2) { Property.create( lng: 12.407021, lat: 52.5329014, zip_code: 111, city: 'Berlin') }
      let!(:property3) { Property.create( lng: 12.407021, lat: 52.5329014, zip_code: 111, city: 'Berlin') }
      subject { Property.nearest(52.5329014, 13.407021).to_a }
      it { is_expected.to match_array [property1] }
    end
  end
end
