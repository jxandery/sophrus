class ChangeTradeVolumeToQty < ActiveRecord::Migration[5.2]
  def change
    rename_column :trades, :volume, :quantity
  end
end
