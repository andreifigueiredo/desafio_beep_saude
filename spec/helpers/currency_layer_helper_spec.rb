require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CurrencyLayerHelper. For example:
#
# describe CurrencyLayerHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe CurrencyLayerHelper, type: :helper do
  describe "get_current_rate" do
    it "should return a json with the wright keys" do 
      expect(helper.get_current_rate.keys).to contain_exactly("success", "terms", "privacy", "timestamp", "source", "quotes")
    end
  end

  describe "get_time_frame" do
    it "should return a json with the wright keys" do
      expect(helper.get_time_frame(Time.now-4.days, Time.now).keys).to contain_exactly("end_date", "privacy", "quotes", "source", "start_date", "success", "terms")
    end

    it "should return the wright start_date" do
      expect(helper.get_time_frame(Time.now-4.days, Time.now)["start_date"]).to eq((Time.now-4.days).strftime("%Y-%m-%d"))
    end

    it "should return the wright end_date" do
      expect(helper.get_time_frame(Time.now-4.days, Time.now)["end_date"]).to eq((Time.now).strftime("%Y-%m-%d"))
    end
  end
end
