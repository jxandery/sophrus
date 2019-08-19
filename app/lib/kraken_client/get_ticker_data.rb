module KrakenClient
  class GetTickerData

    def self.call(symbols)
      begin
        Kraken::Client.new(symbols).call
      rescue => e
        SLACK.ping("There was an error getting ticker data for symbols: #{symbols.join(' ')}, channel: '#system-notifs')
      end
      Rails.logger.error("There was an error getting ticker data: #{e.inspect}")
      nil
    end
  end
end
