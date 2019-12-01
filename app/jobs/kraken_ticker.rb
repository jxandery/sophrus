class KrakenTicker < ActiveJob::Base
  @queue = :default

  def perform(symbols)
    ticker_data = KrakenClient::GetTickerData.call(symbols)
    # tickers_data.each do |ticker_data|
      KrakenData.new(ticker_data).validate_data
      GroupHourlyData.new(ticker_data).call
      # FeedToAlgos.call(ticker_data)
    # end
  end
end
