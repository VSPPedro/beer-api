require 'rails_helper'

RSpec.describe Beer, type: :model do
  let(:beer) { build(:beer) }
  # Field test
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:fabrication) }
  # Association test
  it { is_expected.to have_many(:creators) }
  it { is_expected.to have_many(:tips) }
  # Validation test
  it { should validate_presence_of(:name) }
end
