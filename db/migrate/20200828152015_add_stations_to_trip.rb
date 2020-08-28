class AddStationsToTrip < ActiveRecord::Migration[6.0]
  def change
    add_reference :trips, :start_station, foreign_key: { to_table: :stations }
    add_reference :trips, :finish_station, foreign_key: { to_table: :stations }
  end
end
