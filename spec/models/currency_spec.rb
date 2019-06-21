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

  context 'validate scopes' do
    before(:each) do
      @days = 4
      time = Time.now
      past_time = Time.now - @days.days
      while past_time < time
        (0..2).each do |quote|
          FactoryBot.create(:currency, date: past_time, quote: quote)
        end
        past_time += 1.day
      end
    end

    it 'should return the desired quantity of currencies' do
      expect(Currency.get_last_days(@days).length).to eq(@days*3)
    end
  end
end
