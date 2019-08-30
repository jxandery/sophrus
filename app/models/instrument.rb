class Instrument < ApplicationRecord
  has_many :tickers
  validates :symbol, uniqueness: true

end
