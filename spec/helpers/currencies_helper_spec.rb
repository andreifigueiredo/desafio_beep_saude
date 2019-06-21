require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CurrenciesHelper. For example:
#
# describe CurrenciesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe CurrenciesHelper, type: :helper do
  describe "get_currencies" do
    before(:each) do
      @days = 4
    end

    it "should create the desired " do
      expect(CurrenciesHelper.get_currencies(@days).length).to eq(@days*3)
    end

    it "should get the desired " do
      time = Time.now
      past_time = Time.now - @days.days
      while past_time < time
        (0..2).each do |quote|
          FactoryBot.create(:currency, date: past_time, quote: quote)
        end
        past_time += 1.day
      end

      expect(CurrenciesHelper.get_currencies(@days).length).to eq(@days*3)
    end
  end

  describe "create_currencies" do
    before(:each) do
      @days = 4
    end

    it "should create many currencies" do
      expect { CurrenciesHelper.create_currencies(@days) }.to change(Currency, :count).by(@days*3) 
    end

    it "should create one currency" do
      expect { CurrenciesHelper.create_currencies(1) }.to change(Currency, :count).by(3)
    end
  end
end
