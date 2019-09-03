class AddStatusColumnToTrades < ActiveRecord::Migration[5.2]
  def change
    add_column :trades, :status, :string, default: 'pending', null: false
  end
end
