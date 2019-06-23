module CurrencyLayerHelper
  def self.get_current_rate
    live_url = "#{ENV['LAYER_URL']}live?#{ENV['LAYER_KEY']}&#{ENV['LAYER_CURRENCIES']}"
    HTTParty.get(live_url, debug_output: $stdout)
  end

  def self.get_time_frame(start_date, end_date)
    day = start_date + 1.day 
    time_frame_response = {}
    time_frame_response[:quotes] = {}
    while day.beginning_of_day < end_date.end_of_day.end_of_day
      historical = "#{ENV['LAYER_URL']}historical?#{ENV['LAYER_KEY']}&date=#{day.strftime("%Y-%m-%d")}&#{ENV['LAYER_CURRENCIES']}"
      day_response = HTTParty.get(historical, debug_output: $stdout)
      unless day_response['success']
        time_frame_response[:success] = day_response['success']
        time_frame_response[:error] = day_response['error']
        break
      end
      if day_response['date'] == (start_date+1.day).strftime("%Y-%m-%d")
        time_frame_response[:start_date] = day_response['date']
      end
      if day_response['date'] == end_date.strftime("%Y-%m-%d")
        time_frame_response[:success] = day_response['success']
        time_frame_response[:terms] = day_response['terms']
        time_frame_response[:privacy] = day_response['privacy']
        time_frame_response[:source] = day_response['source']
        time_frame_response[:end_date] = day_response['date']
      end
      time_frame_response[:quotes]["#{day_response['date']}"] = day_response['quotes']
      day += 1.day  
    end
    time_frame_response.as_json
  end
end