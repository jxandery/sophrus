require 'rails_helper'

RSpec.describe KrakenDataHelper do
  describe '#time_stamped' do
    context 'when successful' do
      before do
        TimeCop.freeze('2019-09-03 08:07:03')
      end

      subject do
        Ticker.time_stamped(data)
      end

      it 'adds time stamp in seconds' do
        data = {}
        subject

        expect(data[:min_sec]).to eq({time_stamp_sec: '07m-03s'})
      end
    end

    context 'errors out' do
      it 'returns a Name Error' do
        data = nil

        expect(subject).to raise_error(NameError)
      end
    end
  end

  describe '#log_tick_data_error' do
    context 'when successful' do
      it 'pings slack' do
        allow(SLACK).to receive(:ping)
        allow(SLACK).to receive(:ping)
        time_key = 'time key'

        Ticker.log_tick_data_error(data, time_key)

        expect(SLACK).to have_received(:ping).with("Tick level error for time_key: error 1", channel: '#system-notifs')
        expect(SLACK).to have_received(:ping).with("Tick level error for time_key: error 2", channel: '#system-notifs')
      end
    end

    context 'errors out' do
      it 'returns a Name Error' do
        data = nil

        expect(subject).to raise_error(NameError)
      end
  end
end
