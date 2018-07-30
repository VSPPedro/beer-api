class Tip < ApplicationRecord
  belongs_to :beer
  validates_presence_of :description, :beer_id
end
