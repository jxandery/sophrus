class KrakenTickerJob < ApplicationJob
  def perform(symbols)
    ticker_data = KrakenClient::GetTickerData.call(symbols)
    ticker_data.each do |data|
      Group_hourly_data.call(data)
    end
  end
end
