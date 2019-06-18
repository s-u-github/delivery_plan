class CreateBases < ActiveRecord::Migration[5.1]
  def change
    create_table :bases do |t|
      t.string  :base_name
      t.integer :postcode
      t.string  :address

      t.timestamps
    end
  end
end