class Ticker < ApplicationRecord
  belongs_to :instrument
  validates :instrument, :time_key, presence: true

  class Tick < SimpleDelegator
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def symbol
      instrument.symbol
    end

    def valid_instrument?
      symbol == pair_name
    end

    def error
      data[:error]
    end

    def pair_name
      data[:result].keys.first.to_s
    end

    def tick_data
      data[:result][symbol]
    end

    def ask
      # a = ask array(<price>, <whole lot volume>, <lot volume>),
      tick_data[:a]
    end

    def bid
      # b = bid array(<price>, <whole lot volume>, <lot volume>),
      tick_data[:b]
    end

    def close
      # c = last trade closed array(<price>, <lot volume>),
      tick_data[:c]
    end

    def volume
      # v = volume array(<today>, <last 24 hours>),
      tick_data[:v]
    end

    def vol_wgt_avg
      # p = volume weighted average price array(<today>, <last 24 hours>),
      tick_data[:p]
    end

    def number_of_trades
      # t = number of trades array(<today>, <last 24 hours>),
      tick_data[:t]
    end

    def low
      # l = low array(<today>, <last 24 hours>),
      tick_data[:l]
    end

    def high
      # h = high array(<today>, <last 24 hours>),
      tick_data[:h]
    end

    def open
      # o = today's opening price
      tick_data[:o]
    end
  end
end
