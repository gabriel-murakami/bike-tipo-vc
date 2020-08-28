class CreateStations < ActiveRecord::Migration[6.0]
  def change
    create_table :stations do |t|
      t.integer :status
      t.string :name
      t.integer :spots_number
      t.references :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
