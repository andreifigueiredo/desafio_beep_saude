module CurrencyHelper
  def self.get_currencies(days)
    currencies = Currency.get_last_days(days)
    if currencies.length < days
      days_missing = days - currencies.length
      self.create_currencies(days_missing)
      currencies = Currency.get_last_days(days) 
    else
      return currencies
    end
  end

  def self.create_currencies(days)
    if days == 1
      request_response = CurrencyLayerHelper.get_current_rate
      request_response['quotes'].each do |key, value|
        Currency.create(quote: key, value: value, date: Time.now.strftime("%Y-%m-%d"))
      end
    else 
      request_response = CurrencyLayerHelper.get_time_frame(Time.now-days.days, Time.now)
      # binding.pry
      request_response['quotes'].each do |key, value|
        value.each do |hash_key, hash_value|
          Currency.create(quote: hash_key, value: hash_value, date: key.to_date)
        end
      end
    end
  end
end