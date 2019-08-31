class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.references :instrument, index: true
      t.string :status, null: false
      t.boolean :profitable

      t.timestamps
    end
  end
end
