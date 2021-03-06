require 'rails_helper'

RSpec.describe Ticker, type: :model do
  describe '' do
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

    context 'when errors out' do
      xit 'pings slack' do
        allow(SLACK).to receive(:ping)

        Ticker.group_hourly_data(instrument, data)

        expect(SLACK).to have_received(:ping).with("Error: .group_hourly_data failed for #{instrument.symbol} at #{time_key}", channel: '#system-notifs')
      end

    end

    context 'when successful' do
      xit 'returns tick level data' do
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
  end
end
