class Volume < ApplicationRecord
  has_many :beer_volumes
  has_many :beers, through: :beer_volumes
  validates :value, :unit, presence: true
end
