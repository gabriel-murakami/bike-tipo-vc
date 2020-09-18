# frozen_string_literal: true

class AddDueDateToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :due_date, :integer
  end
end
