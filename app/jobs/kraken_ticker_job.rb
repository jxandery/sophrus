class KrakenTickerJob < ApplicationJob
  def perform(symbols)
    ticker_data = KrakenClient::GetTickerData.call(symbols)
    ticker_data.each do |data|
      begin
        pair_name = data[:result].keys.first
        instrument = Instrument.find_by(symbol: pair_name)
        Ticker.group_hourly_data(instrument, data)
      rescue => e
        time_key = "#{Time.now.year}-#{Time.now.month}-#{Time.now.day}-#{Time.now.hour}"

        SLACK.ping("Error: .group_hourly_data failed for #{instrument.symbol} at #{time_key}", channel: '#system-notifs')
        Rails.logger.error("There was a .group_hourly_data error for #{instrument.symbol} at #{time_key}: #{e.inspect}")
      end
    end
  end
end
