class AddForeignKey < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :prices, :instruments
    add_foreign_key :tickers, :instruments
  end
end
