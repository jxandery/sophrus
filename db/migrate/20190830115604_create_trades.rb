class CreateTrades < ActiveRecord::Migration[5.2]
  def change
    create_table :trades do |t|
      t.references :instrument, index: true
      t.references :position, index: true
      t.string :type, null: false
      t.string :order_type, null: false
      t.string :volume, null: false
      t.string :price, null: false
      t.string :filled_at_price

      t.timestamps
    end
  end
end
