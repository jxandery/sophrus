module KrakenClient
  class GetTickerData

    def self.call(symbols)
      begin
        client = Kraken::Client.new
        client.ticker(symbols)
      rescue => e
        SLACK.ping("There was an error retrieving Ticker data for symbols: #{symbols}")
        Rails.logger.error("There was an error getting ticker data: #{e.inspect}")
      end
    end
  end
end
