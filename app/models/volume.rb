class Volume < ApplicationRecord
  has_many :beer_volumes
  has_many :beers, through: :beer_volumes
  validates_presence_of :value, :unit
end
