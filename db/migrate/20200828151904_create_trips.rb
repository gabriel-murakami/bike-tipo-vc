class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.references :bike, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :finish_time

      t.timestamps
    end
  end
end
