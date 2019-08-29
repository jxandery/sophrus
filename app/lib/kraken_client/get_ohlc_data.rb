module KrakenClient
  class GetOhlcData

    def self.call(symbol, interval)
      begin
        client = Kraken::Client.new(symbol, interval)
        client.ohlc(pair: symbol, interval: interval)
      rescue => e
        SLACK.ping("There was an error getting OHLC data for symbol: #{symbol} at #{interval} min(s) intervals", channel: '#system-notifs')
        Rails.logger.error("There was an error getting OHLC data: #{e.inspect}")
      end
    end
  end
end
