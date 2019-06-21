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
    it "should return a json with the desired keys" do 
      expect(CurrencyLayerHelper.get_current_rate.keys).to contain_exactly("success", "terms", "privacy", "timestamp", "source", "quotes")
    end
  end
  
  describe "get_time_frame" do
    before(:each) do
      @days = 4
    end
    
    context "when success" do
      it "should return a json with the desired keys" do
        expect(CurrencyLayerHelper.get_time_frame(Time.now-@days.days, Time.now).keys).to contain_exactly("end_date", "privacy", "quotes", "source", "start_date", "success", "terms")
      end

      it "should return the desired start_date" do
        expect(CurrencyLayerHelper.get_time_frame(Time.now-@days.days, Time.now)["start_date"]).to eq((Time.now-@days.days+1.day).strftime("%Y-%m-%d"))
      end

      it "should return the desired end_date" do
        expect(CurrencyLayerHelper.get_time_frame(Time.now-@days.days, Time.now)["end_date"]).to eq((Time.now).strftime("%Y-%m-%d"))
      end

      it "should return a json with the desired quantity of quotes" do
        expect(CurrencyLayerHelper.get_time_frame(Time.now-@days.days, Time.now)["quotes"].length).to eq(@days)
      end
    end
    context "when fails" do
      before(:each) do
        allow(HTTParty).to receive(:get).with("#{ENV['LAYER_URL']}historical?#{ENV['LAYER_KEY']}&date=#{(Time.now-(@days-1).days).strftime("%Y-%m-%d")}&#{ENV['LAYER_CURRENCIES']}", any_args).and_return({
          "success": false,
          "error": {
            "code": 104,
            "info": "Your monthly usage limit has been reached. Please upgrade your subscription plan."    
          }
        }.as_json)
      end
      it "return a json with the desired keys" do
        expect(CurrencyLayerHelper.get_time_frame(Time.now-@days.days, Time.now).keys).to contain_exactly("success", "error", "quotes")
      end

      it "should return success false" do
        expect(CurrencyLayerHelper.get_time_frame(Time.now-@days.days, Time.now)["success"]).to eq(false)
      end

      it "should not return nil error" do
        expect(CurrencyLayerHelper.get_time_frame(Time.now-@days.days, Time.now)["error"].nil?).to eq(false)
      end
    end
  end
end
