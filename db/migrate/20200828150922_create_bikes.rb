class CreateBikes < ActiveRecord::Migration[6.0]
  def change
    create_table :bikes do |t|
      t.integer :status
      t.references :station, null: false, foreign_key: true

      t.timestamps
    end
  end
end
