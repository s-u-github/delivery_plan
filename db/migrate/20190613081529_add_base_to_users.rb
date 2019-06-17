class AddBaseToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :base, foreign_key: true
  end
end
