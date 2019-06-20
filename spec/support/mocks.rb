RSpec.configure do |config|
  config.before(:each) do
    # Mock live
    allow(HTTParty).to receive(:get).with("#{ENV['LAYER_URL']}live?#{ENV['LAYER_KEY']}&#{ENV['LAYER_CURRENCIES']}", any_args).and_return({
      "success": true,
      "terms": "https://currencylayer.com/terms",
      "privacy": "https://currencylayer.com/privacy",
      "timestamp": 1561031945,
      "source": "USD",
      "quotes": {
          "USDBRL": 3.83895,
          "USDEUR": 0.884295,
          "USDARS": 43.335978
      }
    }.as_json)
    
    # Mock historical
    today = Time.now+1.day
    past_day = Time.now-30.days
    while past_day < today
      allow(HTTParty).to receive(:get).with("#{ENV['LAYER_URL']}historical?#{ENV['LAYER_KEY']}&date=#{past_day.strftime("%Y-%m-%d")}&#{ENV['LAYER_CURRENCIES']}", any_args).and_return({
        "success": true,
        "terms": "https://currencylayer.com/terms",
        "privacy": "https://currencylayer.com/privacy",
        "historical": true,
        "date": past_day.strftime("%Y-%m-%d"),
        "timestamp": 1561056786,
        "source": "USD",
        "quotes": {
            "USDBRL": 3.839201,
            "USDEUR": 0.885885,
            "USDARS": 43.336499
        }
      }.as_json)
      past_day+=1.day
    end
  end
end