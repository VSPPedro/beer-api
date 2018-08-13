class Tip < ApplicationRecord
  belongs_to :beer
  validates :description, presence: true
end
