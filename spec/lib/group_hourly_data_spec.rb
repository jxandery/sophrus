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

    subject do
      GroupHourlyData.call(data.first)
    end

    context 'when errors out' do
      xit 'pings slack' do
        allow(SLACK).to receive(:ping)

        subject

        expect(SLACK).to have_received(:ping).with("Error: GroupHourlyData.call failed for #{instrument.symbol} at #{time_key}", channel: '#system-notifs')
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
