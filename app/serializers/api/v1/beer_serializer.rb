class Api::V1::BeerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :fabrication
  has_many :tips
  has_many :creators
  has_many :volumes
end
