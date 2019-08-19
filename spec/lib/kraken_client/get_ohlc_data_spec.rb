require 'rails_helper'

describe Kraken::GetOhlcData do
  describe '#call' do
    let(:symbol) { "BTCZUSD" }

    subject do
      Kraken::GetTickerData.new(symbol).call
    end

    context 'when an error occurs retrieving ticker data' do
      before do
        allow(Kraken::Client).to receive(:get_ticker_data).and_raise(StandardError)
      end

      it 'returns an empty array' do
        expect(subject).to eq([])
      end

      it 'pings the appropriate slack channel' do
        allow(SLACK).to receive(:ping)

        subject

        expect(SLACK).to have_received(:ping).with("There was an error retrieving Kraken data for symbol: 'BTXCZUSD' at 1 min(s) ", channel: '#system-notifs')
      end
    end

    context 'when successful' do
      before do
        allow(Kraken::Client).to receive(:get_ticker_data).with(:new).and_return([])
      end

      it 'returns true' do
        expect(Kraken::GetTickerData.new(symbol).call).to eq([])
      end
    end
  end
end
