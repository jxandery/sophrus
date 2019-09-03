class GroupHourlyData
  include KrakenDataHelper
  include TimeKeyHelper

  def self.call(data)
    instrument = Instrument.find_by(symbol: find_symbol(data))
    time_key = time_key
  begin
    ticker = create_or_find_by!(instrument: instrument, time_key: time_key)

    log_tick_data_error(data, time_key)

    ticker.data << time_stamped(data)
    ticker.save!
  rescue => e
    SLACK.ping("Error: .group_hourly_data failed for #{instrument.symbol} at #{time_key}", channel: '#system-notifs')
    Rails.logger.error("There was a .group_hourly_data error for #{instrument.symbol} at #{time_key}: #{e.inspect}")
  end
end
