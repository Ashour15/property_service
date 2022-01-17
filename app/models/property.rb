class Property < ApplicationRecord
  # Extensions --------------------------------------------------------
  acts_as_geolocated

  # Constants ---------------------------------------------------------
  # Value in Kilometers
  DEFAULT_RADIUS = 50000
 
  # Scopes ------------------------------------------------------------
  scope :nearest,           ->(lat, lng) { within_radius(DEFAULT_RADIUS, lat, lng).order_by_distance(lat, lng) }
  scope :by_property_type,  ->(type)     { where(property_type: type) }
  scope :by_offer_type,     ->(type)     { where(offer_type: type) }
end
