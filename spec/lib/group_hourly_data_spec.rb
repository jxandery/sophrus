require 'rails_helper'

RSpec.describe GroupHourlyData do
  describe '.call' do
    let(:data) do
      [
        {
          'error': ['error 1', 'error 2'],
          'result': {
            'XXBTZUSD': {
              'a': ['8466.90000', '1', '1.000'],
              'b': ['8464.10000', '1', '1.000'],
              'c': ['8464.50000', '0.21218942'],
              'v': ['3171.04602409', '5795.97762632'],
              'p': ['8528.77032', '8611.98288'],
              't': [8319, 17457],
              'l': ['8350.00000', '8350.00000'],
              'h': ['8746.00000', '8841.30000'],
              'o': '8740.00000'
            }
          }
        }
      ]
    end


    let(:symbol) { 'XXBTZUSD'.to_sym }
    let!(:instrument) { Instrument.create(symbol: symbol) }

    before do
      Timecop.freeze('6/1/2015 01:23:45 MST')
    end

    subject do
      GroupHourlyData.new(data.first).call
    end

    context 'when errors out' do
      it 'pings slack' do
        ticker_double = double(:ticker)
        allow(Ticker).to receive(:find_or_create_by!).and_return(ticker_double)
        allow(ticker_double).to receive(:data)
        allow(ticker_double).to receive(:save!).and_return(StandardError)
        allow(SLACK).to receive(:ping).exactly(3).times

        subject

        expect(SLACK).to have_received(:ping).with("Tick level error for 15-01-06-01. Error: error 1")
        expect(SLACK).to have_received(:ping).with("Tick level error for 15-01-06-01. Error: error 2")
        expect(SLACK).to have_received(:ping).with("Error: GroupHourlyData failed for #{instrument.symbol} at 15-01-06-01")
      end

    end

    context 'when successful' do
      it 'creates ticker record' do
        subject

        expect(Ticker.count).to eq(1)
      end
    end
  end
end
