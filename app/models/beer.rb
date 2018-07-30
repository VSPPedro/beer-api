class Beer < ApplicationRecord
  has_many :creators, dependent: :destroy
  validates_presence_of :name
end
