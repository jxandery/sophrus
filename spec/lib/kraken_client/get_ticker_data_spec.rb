require 'rails_helper'

describe KrakenClient::GetTickerData do
  describe '#call' do
    let(:symbols) do
      { pair: "BTCZUSD" }
    end

    subject do
      KrakenClient::GetTickerData.call(symbols)
    end

    context 'when an error occurs retrieving ohlc data' do
      before do
        allow(Kraken::Client).to receive(:new).and_raise(StandardError)
      end

      it 'returns ah Array' do
        expect(subject).to eq([])
      end

      it 'pings the appropriate slack channel' do
        allow(SLACK).to receive(:ping)

        subject

        expect(SLACK).to have_received(:ping).with("There was an error retrieving Ticker data for symbols: 'BTXCZUSD' ", channel: '#system-notifs')
      end
    end

    context 'when successful' do
      before do
        allow(Kraken::Client).to receive(:new).with(:symbols).and_return([])
      end

      it 'returns true' do
        expect(subject).to eq([])
      end
    end
  end
end
