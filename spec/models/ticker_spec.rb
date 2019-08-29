require 'rails_helper'

RSpec.describe Ticker, type: :model do
  describe '.group_hourly_data' do
    context 'when successful' do
      let(:data) do
        [
          {
            "error":['error 1', 'error 2'],
            "result":{
              "XXBTZUSD":{
                "a":["8466.90000", "1", "1.000"],
                "b":["8464.10000", "1", "1.000"],
                "c":["8464.50000", "0.21218942"],
                "v":["3171.04602409", "5795.97762632"],
                "p":["8528.77032", "8611.98288"],
                "t":[8319, 17457],
                "l":["8350.00000", "8350.00000"],
                "h":["8746.00000", "8841.30000"],
                "o":"8740.00000"
              }
            }
          }
        ]
      end


      let(:symbol) { 'XXBTZUSD'.to_sym }
      let(:instrument) { Instrument.create(symbol: symbol) }

      subject do
        Ticker.group_hourly_data(instrument, data.first)
      end

      it 'creates ticker record' do
        subject

        expect(Ticker.count).to eq(1)
      end

      it 'returns tick level data' do
        subject

        #not sure how to do this.
        tick = subject.tick

        expect(ticker.data).to eq(data)
        expect(ticker.data.error).to eq(['error 1', 'error 2'])
        expect(ticker.data.valid_instrument?).eq(true)
        expect(ticker.data.pair_name).eq("XXBTZUSD")
        expect(ticker.data.ask).eq(["8466.90000", "1", "1.000"])
        expect(ticker.data.bid).to eq(["8464.10000", "1", "1.000"])
        expect(ticker.data.close).to eq(["8464.50000", "0.21218942"])
        expect(ticker.data.volume).to eq(["3171.04602409", "5795.97762632"])
        expect(ticker.data.vol_wgt_avg).to eq(["8528.77032", "8611.98288"])
        expect(ticker.data.number_of_trades).to eq([8319, 17457])
        expect(ticker.data.low).to eq(["8350.00000", "8350.00000"])
        expect(ticker.data.high).to eq(["8746.00000", "8841.30000"])
        expect(ticker.data.open).to eq("8740.00000")
      end
    end

    context '.time_stamped' do
      it 'adds time stamp in seconds' do
        TimeCop.freeze('some time in seconds ending in 3') do
          data = {}
          Ticker.time_stamped(data)
        end

        expect(data[:min_sec]).to eq({time_stamp_sec: '07m-03s'})
      end

    end

    context '.log_tick_data_error' do
      it 'pings slack' do
        allow(SLACK).to receive(:ping)
        allow(SLACK).to receive(:ping)
        time_key = 'time key'

        Ticker.log_tick_data_error(data, time_key)

        expect(SLACK).to have_received(:ping).with("Tick level error for time_key: error 1", channel: '#system-notifs')
        expect(SLACK).to have_received(:ping).with("Tick level error for time_key: error 2", channel: '#system-notifs')
      end
    end

  end
end
