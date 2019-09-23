class GroupHourlyData
  include TimeKeyHelper
  attr_reader :data, :instrument, :time_key

  def initialize(ticker_data)
    @data = KrakenData.new(ticker_data)
    @instrument = Instrument.find_by(symbol: data.find_symbol)
    @time_key = TimeKeyHelper.call
  end

  def call
    begin
      ticker = Ticker.find_or_create_by!(instrument: instrument, time_key: time_key)

      data.log_tick_data_error(time_key)

      ticker.data << data.time_stamped.to_json
      ticker.save!
    rescue => e
      binding.pry
      SLACK.ping("Error: GroupHourlyData failed for #{instrument.symbol} at #{time_key}")
      Rails.logger.error("There was a GroupHourlyData error for #{instrument.symbol} at #{time_key}: #{e.inspect}")
    end
  end
end
