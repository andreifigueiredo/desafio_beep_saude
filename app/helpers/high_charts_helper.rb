module HighChartsHelper
  def self.newChart(currencies, title)
    Daru::View.plotting_library = :highcharts
    @data = []
    
    currencies.each do |currency|
      @data << [currency.date.utc.to_i*1000, currency.value]
    end
    
    opts = {
      title: {
        text: "DOLAR X #{title}"
      }
    }

    dataframe = Daru::DataFrame.new({
      date: @data.map {|row| row[0]},
      "#{title}": @data.map {|row| row[1]}
    })

    Daru::View::Plot.new(dataframe, opts, chart_class: 'stock')
  end
end
