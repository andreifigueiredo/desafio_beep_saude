class Currency < ApplicationRecord
  enum quote: {
    BRL: 0,
    EUR: 1,
    ARS: 2
  }
end
