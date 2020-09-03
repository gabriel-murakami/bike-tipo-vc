class AddBikeToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :bikes, :user, index: true, foreign_key: true, null: true
  end
end
