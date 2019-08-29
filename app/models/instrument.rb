class Instrument < ApplicationRecord
  has_many :prices, :tickers
  validates :symbol, uniqueness: true

end
