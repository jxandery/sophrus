module KrakenClient
  class GetOhlcData

    def self.call(symbol, interval)
      begin
        kraken = Kraken::Client.new(symbol, interval)
        kraken.ohlc(pair: symbol, interval: interval)
      rescue => e
        SLACK.ping("There was an error getting ohlc data for symbol: #{symbol} at #{interval.to_s} min(s), channel: '#system-notifs')
      end
      Rails.logger.error("There was an error getting ticker data: #{e.inspect}")
      nil
      end
    end
  end
end
