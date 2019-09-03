require 'rails_helper'

RSpec.describe KrakenClient::BuyToOpen do
  describe '#buy_to_open' do
    let(:order) do
      instrument: Fabricate(:bitcoin),
      position: Fabricate(:open_position),
      type: 'buy',
      order_type: 'limit',
      quantity: '7.00',
      price: '1000.00',
    end

    let(:options) do

    end

    subject do
      KrakenClient::BuyToOpen.call(order, position)
    end

    context 'when successful' do
      before do
        allow(Kraken::Client).to receive(:add_order).with(options).and_return([])
      end
      it 'initiates trade with Kraken' do

      end

      it 'creates or adds to a position' do
      end

      it 'creates a trade' do
      end

      it 'pings slack with Kraken order confirmation notification' do

      end

      it 'pings slack with position opened notification if none open' do

      end

      it 'pings slack with position added to notification if a position already open' do

      end

      it 'pings slack with trade created notification' do

      end
    end

    context 'when it errors' do
      before do
        allow(Kraken::Client).to receive(:new).and_raise(StandardError)
      end

      it 'returns an Array' do
        expect(subject).to eq([])
      end

      it 'pings the appropriate slack channel' do
        allow(SLACK).to receive(:ping)

        subject

        expect(SLACK).to have_received(:ping).with("There was an error retrieving Ticker data for symbols: 'BTXCZUSD' ", channel: '#system-notifs')
      end
      it 'initiates trade with Kraken' do
      end
    end
  end
end
