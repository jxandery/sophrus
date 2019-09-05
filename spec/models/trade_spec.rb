require 'rails_helper'

RSpec.describe Trade, type: :model do
  describe '#valid?' do
    context 'when successful' do
      let(:symbol) { 'BTCZUSD' }
      let(:instrument) { Instrument.create(symbol: symbol) }
      let(:position) { Position.create(instrument: instrument) }

      subject do
        Trade.create(
          instrument: instrument,
          position: position,
          order_type: 'buy',
          entry_type: 'market',
          quantity: 1,
          price: '9500.0000'
        )
      end

      it 'is valid' do
        expect(subject).to be_valid
      end

      it 'returns a default status of pending' do
        expect(subject.status).to eq('pending')
      end
    end

    context 'when it errors' do
      let(:symbol) { 'BTCZUSD' }
      let(:instrument) { Instrument.create(symbol: symbol) }
      let(:position) { Position.create(instrument: instrument) }

      subject do
        Trade.create(
          instrument: instrument,
          position: position,
          order_type: 'n/a',
          entry_type: 'n/a',
          status: 'n/a',
          quantity: 1,
          price: '9500.0000'
        )
      end

      it 'returns error messages' do
        expect(subject.errors.messages[:order_type]).to eq(['n/a is not a valid order type (buy/sell)'])
        expect(subject.errors.messages[:entry_type]).to eq(['n/a is not a valid entry type (limit/market)'])
        expect(subject.errors.messages[:status]).to eq(['n/a is not a valid status (pending/filled/canceled)' ])
      end
    end
  end
end
