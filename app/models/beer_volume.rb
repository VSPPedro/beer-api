class BeerVolume < ApplicationRecord
  belongs_to :beer
  belongs_to :volume
  validates :beer_id, :volume_id, presence: true
end
