class PropertiesController < ApplicationController
  has_scope :by_property_type
  has_scope :by_offer_type

  before_action :validate_params, only: [:index]

  def index
    properties = apply_scopes(Property).nearest(params[:lat], params[:lng])

    render json: properties.to_json(:only => [ :house_number, :street, :city, :zip_code, :state, :lat, :lng, :price ])
  end

  private

  def validate_params
    validator = PropertyIndexValidator.new(params)
    
    return if validator.valid?

    render json: { errors: validator.errors }, status: 422
  end
end
