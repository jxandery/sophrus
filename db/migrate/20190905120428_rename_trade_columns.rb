class RenameTradeColumns < ActiveRecord::Migration[5.2]
  def change
    rename_column :trades, :order_type, :entry_type
    rename_column :trades, :type, :order_type
  end
end
