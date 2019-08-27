class AddColumnsToTickers < ActiveRecord::Migration[5.2]
  def change
    add_column :tickers, :time_key, :string
    change_column :tickers, :data, "varchar[] USING (string_to_array(data, ','))"
  end
end
