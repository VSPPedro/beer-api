class Beer < ApplicationRecord
  has_many :creators, dependent: :destroy
  has_many :tips, dependent: :destroy
  has_many :beer_volumes
  has_many :volumes, through: :beer_volumes
  validates :name, presence: true
  accepts_nested_attributes_for :creators
  accepts_nested_attributes_for :tips
  accepts_nested_attributes_for :volumes
end
