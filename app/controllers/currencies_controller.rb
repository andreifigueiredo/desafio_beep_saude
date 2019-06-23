class CurrenciesController < ApplicationController
  def index
    @currencies = CurrenciesHelper.get_currencies(7)

    @brl_line_graph = HighChartsHelper.newChart(@currencies.where(quote: "USDBRL"), "REAL")
    @eur_line_graph = HighChartsHelper.newChart(@currencies.where(quote: "USDEUR"), "EURO")
    @ars_line_graph = HighChartsHelper.newChart(@currencies.where(quote: "USDARS"), "PESO ARGENTINO")
  end
end
