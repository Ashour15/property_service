class PropertyIndexValidator
  include ActiveModel::Validations

  AVAILABLE_PROPERTY_TYPES = %w(apartment single_family_house)
  AVAILABLE_OFFER_TYPES = %w(rent sell)

  attr_reader :data

  validates :lat, numericality: true, presence: true
  validates :lng, numericality: true, presence: true
  validates :by_offer_type, inclusion: AVAILABLE_OFFER_TYPES, presence: true
  validates :by_property_type, inclusion: AVAILABLE_PROPERTY_TYPES, presence: true

  def initialize(data)
    @data = data
  end

  def read_attribute_for_validation(key)
    @data[key]
  end
end