require 'rails_helper'

RSpec.describe Currency, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:currency)).to be_valid
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :value }
    it { is_expected.to validate_presence_of :quote }
    it { is_expected.to validate_presence_of :date }
    it { is_expected.to validate_uniqueness_of(:date).scoped_to(:quote) }
  end
end
