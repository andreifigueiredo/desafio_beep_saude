class Currency < ApplicationRecord
  scope :get_last_days, -> (quantity_of_days) {
    where(date: (Time.now-quantity_of_days.days)..Time.now)
  }
  
  enum quote: {
    USDBRL: 0,
    USDEUR: 1,
    USDARS: 2
  }

  validates_presence_of :value
  validates_presence_of :quote
  validates_presence_of :date

  validates_uniqueness_of :date, :scope => :quote
end
