class CurrenciesController < ApplicationController
  def index
    # set the library, to plot charts
    @currencies = CurrenciesHelper.get_currencies(7)
    # brl_data = []
    # eur_data = []
    # ars_data = []
    # @currencies.each do |currency|
    #   case currency.quote
    #   when "USDBRL"
    #     brl_data << [currency.date.strftime("%d-%m-%Y"), currency.value]
    #   when "USDEUR"
    #     eur_data << [currency.date.strftime("%d-%m-%Y"), currency.value]
    #   when "USDARS"
    #     ars_data << [currency.date.strftime("%d-%m-%Y"), currency.value]
    #   end
    # end
    # binding.pry
    # @brl_line_graph = Daru::View::Plot.new(brl_data)
    # @eur_line_graph = Daru::View::Plot.new(eur_data)
    # @ars_line_graph = Daru::View::Plot.new(ars_data)

    @brl_line_graph = HighChartsHelper.newChart(@currencies.where(quote: "USDBRL"), "REAL")
    @eur_line_graph = HighChartsHelper.newChart(@currencies.where(quote: "USDEUR"), "EURO")
    @ars_line_graph = HighChartsHelper.newChart(@currencies.where(quote: "USDARS"), "PESOS ARGENTINOS")
  end
end
