class AddInstrumentIndexToPricesAndTickers < ActiveRecord::Migration[5.2]
  def change
    remove_column :prices, :instrument_id
    add_reference :prices, :instrument, index: true

    remove_column :tickers, :instrument_id
    add_reference :tickers, :instrument, index: true
  end
end
