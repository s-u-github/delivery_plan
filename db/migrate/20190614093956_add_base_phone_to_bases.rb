class AddBasePhoneToBases < ActiveRecord::Migration[5.1]
  def change
    add_column :bases, :base_phone_num, :string
  end
end
