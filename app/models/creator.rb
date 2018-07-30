class Creator < ApplicationRecord
  belongs_to :beer
  validates_presence_of :name
end
