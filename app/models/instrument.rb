class Instrument < ApplicationRecord
  has_many :tickers
  has_many :positions
  validates :symbol, uniqueness: true

end
