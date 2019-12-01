require 'rails_helper'

describe KrakenClient::GetTickerData do
  describe '#call' do
    let(:symbols) { 'XXBTZUSD, XXRPZUSD' }

    subject do
      KrakenClient::GetTickerData.call(symbols)
    end

    context 'when an error occurs retrieving ticker data' do
      before do
        allow(Kraken::Client).to receive(:new).and_raise(StandardError)
      end

      it 'pings the appropriate slack channel' do
        allow(SLACK).to receive(:ping)

        subject

        expect(SLACK).to have_received(:ping).with('There was an error retrieving Ticker data for symbols: XXBTZUSD, XXRPZUSD')
      end
    end

    context 'when successful' do
      it 'returns error/result keys and symbol keys' do
        expect(subject.keys).to eq(['error', 'result'])
        expect(subject['result'].keys).to eq(['XXBTZUSD', 'XXRPZUSD'])
      end
    end
  end
end
