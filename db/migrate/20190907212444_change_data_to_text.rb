class ChangeDataToText < ActiveRecord::Migration[5.2]
  def up
    remove_column :tickers, :data
    add_column :tickers, :data, :text, default: [], array: true
  end

  def down
    add_column :tickers, :data, :string
    remove_column :tickers, :data, :text, default: [], array: true
  end
end
