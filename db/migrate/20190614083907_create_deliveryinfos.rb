class CreateDeliveryinfos < ActiveRecord::Migration[5.1]
  def change
    create_table :deliveryinfos do |t|
      t.string :guest_name
      t.string :guest_postcode
      t.string :guest_address
      t.string :guest_phone_num
      t.string :email
      t.string :area
      t.boolean :delivery_check, default: "false"

      t.timestamps
    end
  end
end
