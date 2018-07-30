class Beer < ApplicationRecord
  has_many :creators, dependent: :destroy
  has_many :tips, dependent: :destroy
  validates_presence_of :name
end
