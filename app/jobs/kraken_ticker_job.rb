class KrakenTickerJob < ApplicationJob
  def self.perform(symbols)
    tickers_data = KrakenClient::GetTickerData.call(symbols)
    tickers_data.each do |ticker_data|
      KrakenData.new(ticker_data).validate_format
      Group_hourly_data.call(ticker_data)
      # FeedToAlgos.call(ticker_data)
    end
  end
end
