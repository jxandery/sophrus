require 'rails_helper'

RSpec.describe Ticker, type: :model do
  describe '#save' do
    context 'when successful' do
      let(:data) {
        {
          "error":[],
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
        }.symbolize_keys
      }


      let(:symbol) { 'XXBTZUSD'.to_sym }
      let(:instrument) { Instrument.create(symbol: symbol) }

      it 'creates ticker record' do
        # let!(:ticker) { Ticker.create(instrument_id: instrument.id, data: data) }
        ticker = Ticker.new(instrument, data)
       binding.pry
        ticker.save
        expect(ticker.data).to eq(ticker_data[:result][symbol.to_sym])
        expect(ticker.valid_instrument?).eq(true)
        expect(ticker.pair_name).eq("XXBTZUSD")
        expect(ticker.ask).eq(["8466.90000", "1", "1.000"])
        expect(ticker.bid).to eq(["8464.10000", "1", "1.000"])
        expect(ticker.close).to eq(["8464.50000", "0.21218942"])
        expect(ticker.volume).to eq(["3171.04602409", "5795.97762632"])
        expect(ticker.vol_wgt_avg).to eq(["8528.77032", "8611.98288"])
        expect(ticker.number_of_trades).to eq([8319, 17457])
        expect(ticker.low).to eq(["8350.00000", "8350.00000"])
        expect(ticker.high).to eq(["8746.00000", "8841.30000"])
        expect(ticker.open).to eq("8740.00000")
      end

      context 'when an error occurs' do
        xit 'logs error message in slack' do

        end
      end
    end
  end
end
