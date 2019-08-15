class CreateTickers < ActiveRecord::Migration[5.2]
  def change
    create_table :tickers do |t|
      t.bigint :instrument_id, null: false
      t.string :data

      t.timestamps
    end
  end
end
