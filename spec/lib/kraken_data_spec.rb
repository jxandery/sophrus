require 'rails_helper'
require 'active_support/testing/time_helpers'

RSpec.describe KrakenData do
  let(:ticker_data) do
    {
      'error': ['error 1', 'error 2'],
      'result': []
    }
  end

  describe '#validate_data' do
    context 'when successful' do
      it 'returns true' do
        subject = KrakenData.new(ticker_data)

        expect(subject.validate_data).to eq(true)
      end
    end

    context 'when data is not a hash' do
      it 'pings slack' do
        allow(SLACK).to receive(:ping)

        ticker_data = nil
        subject = KrakenData.new(ticker_data)

        expect(subject.validate_data).to eq(false)
        expect(SLACK).to have_received(:ping).with("Kraken provided invalid data.")
      end
    end

    context 'when data is missing required keys' do
      it 'pings slack' do
        allow(SLACK).to receive(:ping)

        ticker_data = {}
        subject = KrakenData.new(ticker_data)

        expect(subject.validate_data).to eq(false)
        expect(SLACK).to have_received(:ping).with("Kraken provided invalid data.")
      end
    end
  end

  describe '#time_stamped' do
    before do
      travel_to('2019-09-03 08:07:03')
    end

    after do
      travel_back
    end

    subject do
      KrakenData.new(ticker_data)
    end

    it 'adds time stamp in seconds' do
      subject.time_stamped

      expect(subject.data[:min_sec]).to eq('07m-03s')
    end
  end

  describe '#log_tick_data_error' do
    subject do
      KrakenData.new(ticker_data)
    end

    context 'when successful' do
      it 'pings slack' do
        allow(SLACK).to receive(:ping)
        allow(SLACK).to receive(:ping)
        time_key = 'time key'

        subject.log_tick_data_error(time_key)

        expect(SLACK).to have_received(:ping).with("Tick level error for time_key. Error: error 1")
        expect(SLACK).to have_received(:ping).with("Tick level error for time_key. Error: error 2")
      end
    end
  end
end
