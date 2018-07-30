require 'rails_helper'

RSpec.describe Volume, type: :model do
  let(:volume) { build(:volume) }
  # Field test
  it { is_expected.to respond_to(:value) }
  it { is_expected.to respond_to(:unit) }
  # Association test
  it { is_expected.to have_many(:beers) }
  # Validation test
  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_presence_of(:unit) }
end
