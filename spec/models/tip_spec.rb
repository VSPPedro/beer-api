require 'rails_helper'

RSpec.describe Tip, type: :model do
  let(:tip) { build(:tip) }
  # Field test
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:beer_id) }
  # Association test
  it { is_expected.to belong_to(:beer) }
  # Validation test
  it { is_expected.to validate_presence_of(:description) }
end
