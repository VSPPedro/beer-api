require 'rails_helper'

RSpec.describe Creator, type: :model do
  let(:creator) { build(:creator) }
  # Field test
  it { is_expected.to respond_to(:name) }
  # Validation test
  it { should validate_presence_of(:name) }
end
