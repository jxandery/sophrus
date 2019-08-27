module KrakenClient
  class GetTickerData

    def self.call(symbols)
      begin
        client = Kraken::Client.new
        client.pairs(pairs: symbols)
      rescue => e
        SLACK.ping("There was an error getting ticker data for symbols: #{symbols.join()}",, channel: '#system-notifs')
        Rails.logger.error("There was an error getting ticker data: #{e.inspect}")
      end
    end
  end
end
