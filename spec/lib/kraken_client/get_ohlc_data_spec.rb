require 'rails_helper'

describe KrakenClient::GetOhlcData do
  describe '#call' do
    let(:symbol) { "BTCZUSD" }
    let(:interval) { 1 }

    subject do
      KrakenClient::GetOhlcData.call(symbol, interval)
    end

    context 'when an error occurs retrieving ohlc data' do
      before do
        allow(Kraken::Client).to receive(:new).and_raise(StandardError)
      end

      it 'returns a hash' do
        expect(subject).to eq({})
      end

      it 'pings the appropriate slack channel' do
        allow(SLACK).to receive(:ping)

        subject

        expect(SLACK).to have_received(:ping).with("There was an error retrieving OHLC data for symbol: 'BTXCZUSD' at 1 min(s) intervals", channel: '#system-notifs')
      end
    end

    context 'when successful' do
      before do
        allow(subject).to receive(:ohlc).with(pair: symbol, interval: interval).and_return({})
      end

      it 'returns true' do
        expect(subject.ohlc(pair: symbol, interval: interval)).to eq({})
      end
    end
  end
end
