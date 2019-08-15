class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.bigint :instrument_id, null: false
      t.string :symbol, null: false
      t.string :open
      t.string :high
      t.string :low
      t.string :close
      t.string :volume
      t.string :vwap
      t.integer :end_time
      t.integer :count

      t.timestamps
    end
  end
end
