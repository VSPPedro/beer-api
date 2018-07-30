require 'rails_helper'

RSpec.describe BeerVolume, type: :model do
  # Field test
  it { is_expected.to respond_to(:beer_id) }
  it { is_expected.to respond_to(:volume_id) }
  # Association test
  it { is_expected.to belong_to(:beer) }
  it { is_expected.to belong_to(:volume) }
  # Validation test
  it { should validate_presence_of(:beer_id) }
  it { should validate_presence_of(:volume_id) }
end
