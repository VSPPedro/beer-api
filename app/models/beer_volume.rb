class BeerVolume < ApplicationRecord
  belongs_to :beer
  belongs_to :volume
  validates_presence_of :beer_id, :volume_id
end
