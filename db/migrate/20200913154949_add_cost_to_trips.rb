class AddCostToTrips < ActiveRecord::Migration[6.0]
  def change
    add_column :trips, :cost, :float
  end
end
