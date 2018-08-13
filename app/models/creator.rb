class Creator < ApplicationRecord
  belongs_to :beer
  validates :name, presence: true
end
