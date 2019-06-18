module CurrencyLayerHelper
  def self.get_current_rate
    live_url = "#{ENV['LAYER_URL']}live?access_key=#{ENV['LAYER_KEY']}&currencies=BRL,EUR,ARS"
    HTTParty.get(live_url)
  end

  def self.get_time_frame(start_date, end_date)
    day = start_date
    time_frame_response = []
    while day < end_date
      time_frame_url = "#{ENV['LAYER_URL']}historical?access_key=#{ENV['LAYER_KEY']}&date=#{day.strftime("%Y-%m-%d")}&currencies=BRL,EUR,ARS"
      time_frame_response << HTTParty.get(time_frame_url)
      day += 1.day  
    end
    time_frame_response
  end
end