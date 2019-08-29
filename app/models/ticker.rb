class Ticker < ApplicationRecord
  validates :instrument, :time_key, presence: true
  # serialize :data

  attr_reader :instrument, :data, :time_key

  def initialize(instrument:, data:, time_key:)
    @instrument = instrument
    @data = data.symbolize_keys
    @time_key = time_key
  end

  def self.group_hourly_data(instrument, data)
    time_key = "#{Time.now.year}-#{Time.now.month}-#{Time.now.day}-#{Time.now.hour}"
    ticker = create_or_find_by!(instrument: instrument, time_key: time_key)

    log_tick_data_error(data, time_key)

    ticker.data << time_stamped(data)
    ticker.save!
  end

  def self.time_stamped(data)
    min = Time.now.min.to_s.rjust(2, '0')
    sec = Time.now.sec.to_s.rjust(2, '0')
    data[:min_sec] = "#{min}-#{sec}"
    data
  end

  def self.log_tick_data_error(data, time_key)
    data[:error].each do |e|
      SLACK.ping("Tick level error for #{time_key}: #{e}", channel: '#system-notifs')
      Rails.logger.error("There was a tick level error for #{time_key}: #{e.inspect}")
    end
  end

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
