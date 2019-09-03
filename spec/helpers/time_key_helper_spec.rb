require 'rails_helper'

RSpec.describe TimeKeyHelper do
  describe '#time_key' do
    context 'when successful' do
      before do
        TimeCop.freeze('2019-09-03 08:07:03')
      end

      it 'returns string yy-mm-dd-hh' do
        expect(time_key).to eq('19-09-03-08-07')
      end
    end

    context 'errors out' do
        time_key = nil

        expect(time_key).to raise_error(StandardError)
      end
    end
  end
end
