class Beer < ApplicationRecord
  has_many :creators, dependent: :destroy
  has_many :tips, dependent: :destroy
  has_many :beer_volumes
  has_many :volumes, through: :beer_volumes
  validates_presence_of :name
end
