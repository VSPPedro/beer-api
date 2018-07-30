require 'rails_helper'

RSpec.describe Creator, type: :model do
  let(:creator) { build(:creator) }
  # Field test
  it { is_expected.to respond_to(:name) }
  # Association test
  it { is_expected.to belong_to(:beer) }
  # Validation test
  it { should validate_presence_of(:name) }
end
