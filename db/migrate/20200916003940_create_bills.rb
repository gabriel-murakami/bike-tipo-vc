# frozen_string_literal: true

class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.references :user, null: false, foreign_key: true
      t.float :value
      t.date :expires_at

      t.timestamps
    end
  end
end
