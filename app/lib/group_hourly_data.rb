class GroupHourlyData
  include KrakenDataHelper
  include TimeKeyHelper

  def self.call(data)
    # seems strange that including a module requires naming that module before
    # using that method

    instrument = Instrument.find_by(symbol: KrakenDataHelper.find_symbol(data))
    time_key = TimeKeyHelper.time_key
    begin
      ticker = Ticker.find_or_create_by!(instrument: instrument, time_key: time_key)

      KrakenDataHelper.log_tick_data_error(data, TimeKeyHelper.time_key)

      ticker.data << KrakenDataHelper.time_stamped(data).to_json
      ticker.save!
    rescue => e
      SLACK.ping("Error: GroupHourlyData.call failed for #{instrument.symbol} at #{time_key}", channel: '#system-notifs')
      Rails.logger.error("There was a GroupHourlyData.call error for #{instrument.symbol} at #{time_key}: #{e.inspect}")
    end
  end
end
