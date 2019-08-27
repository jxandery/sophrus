require 'rails_helper'

describe Kraken::GetTickerData do
  describe '#call' do
    let(:symbols) do
      { pair: "BTCZUSD" }
    end

    subject do
      Kraken::GetTickerData.call(symbols)
    end

    context 'when an error occurs retrieving ticker data' do
      before do
        allow(Kraken::Client).to receive(:get_ticker_data).and_raise(StandardError)
      end

      it 'returns a hash' do
        expect(subject).to eq({})
      end

      it 'pings the appropriate slack channel' do
        allow(SLACK).to receive(:ping)

        subject

        expect(SLACK).to have_received(:ping).with("There was an error retrieving Kraken data for symbols: 'BTXCZUSD' ", channel: '#system-notifs')
      end
    end

    context 'when successful' do
      before do
        allow(Kraken::Client).to receive(:get_ticker_data).with(:new).and_return({})
      end

      it 'returns true' do
        expect(subject).to eq([])
      end
    end
  end
end
