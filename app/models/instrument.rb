class Instrument < ApplicationRecord
  has_many :tickers
  has_many :positions
  validates :symbol, uniqueness: true

  def self.bitcoin
    Instrument.find_by(symbol: 'BTCZUSD')
  end

  def self.litecoin
    Instrument.find_by(symbol: 'LTCZUSD')
  end

  def self.ripple
    Instrument.find_by(symbol: 'XRPZUSD')
  end

  def self.ethereum
    Instrument.find_by(symbol: 'ETHZUSD')
  end

  def self.stellar
    Instrument.find_by(symbol: 'XLMZUSD')
  end
end
