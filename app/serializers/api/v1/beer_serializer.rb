class Api::V1::BeerSerializer < ActiveModel::Serializer
  attributes :id, :name, :fabrication
  has_many :tips
  has_many :creators
  has_many :volumes
end
