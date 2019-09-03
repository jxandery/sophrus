class AddDefaultStatusToPosition < ActiveRecord::Migration[5.2]
  def change
    change_column :positions, :status, :string, :default => 'open'
  end
end
