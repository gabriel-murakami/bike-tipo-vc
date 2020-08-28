class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :district
      t.string :city
      t.integer :number

      t.timestamps
    end
  end
end
