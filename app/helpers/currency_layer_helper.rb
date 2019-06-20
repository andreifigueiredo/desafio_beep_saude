module CurrencyLayerHelper
  def self.get_current_rate
    live_url = "#{ENV['LAYER_URL']}live?access_key=#{ENV['LAYER_KEY']}&currencies=BRL,EUR,ARS"
    HTTParty.get(live_url)
  end

  def self.get_time_frame(start_date, end_date)
    day = start_date
    time_frame_response = {}
    time_frame_response[:quotes] = {}
    while day < end_date
      time_frame_url = "#{ENV['LAYER_URL']}historical?access_key=#{ENV['LAYER_KEY']}&date=#{day.strftime("%Y-%m-%d")}&currencies=BRL,EUR,ARS"
      day_response = HTTParty.get(time_frame_url)
      # binding.pry
      if day_response['date'] == start_date.strftime("%Y-%m-%d")
        if day_response['success']
          time_frame_response[:start_date] = day_response['date']
        else
          time_frame_response[:success] = day_response['success']
          return time_frame_response[:error] = day_response['error']
        end
      end
      if day_response['date'] == (end_date-1.day).strftime("%Y-%m-%d")
        time_frame_response[:success] = day_response['success']
        if time_frame_response[:success]
          time_frame_response[:terms] = day_response['terms']
          time_frame_response[:privacy] = day_response['privacy']
          time_frame_response[:source] = day_response['source']
          time_frame_response[:end_date] = day_response['date']
        else
          return time_frame_response[:error] = day_response['error']
        end
      end
      time_frame_response[:quotes]["#{day_response['date']}"] = day_response['quotes']
      day += 1.day  
    end
    time_frame_response.as_json
  end
end