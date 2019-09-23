require 'rails_helper'

RSpec.describe GroupHourlyData do
  describe '.call' do
    let(:data) do
      {
        'error': ['error 1'],
        'result': {
          'XXBTZUSD': {
          }
        }
      }
    end


    let(:symbol) { 'XXBTZUSD'.to_sym }
    let!(:instrument) { Instrument.create(symbol: symbol) }

    subject do
      GroupHourlyData.new(data).call
    end

    context 'when errors out' do
      let(:data) do
        {
          'error': [],
          'result': {
            'XXBTZUSD': {
            }
          }
        }
      end

      it 'pings slack' do
        # how do you get #save! to fail intentionally
        allow(GroupHourlyData.new(data)).to receive(:call).and_return(StandardError)
        allow(SLACK).to receive(:ping)

        subject

        expect(SLACK).to have_received(:ping).with("Error: GroupHourlyData.call failed for #{instrument.symbol}")
      end

    end

    context 'when successful' do
      it 'creates ticker record' do
        subject

        expect(Ticker.count).to eq(1)
      end

      it 'adds ticker data in JSON form' do
        subject
        ticker_data = Ticker.first.data.first

        expect(JSON.parse(ticker_data).keys).to eq(['error', 'result', 'min_sec'])
      end
    end
  end
end
