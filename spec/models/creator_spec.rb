require 'rails_helper'

RSpec.describe Creator, type: :model do
  let(:creator) { build(:creator) }
  # Field test
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:beer_id) }
  # Association test
  it { is_expected.to belong_to(:beer) }
  # Validation test
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:beer_id) }
end
