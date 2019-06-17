class AddReferencesToDeliveryinfos < ActiveRecord::Migration[5.1]
  def change
    add_reference :deliveryinfos, :base, foreign_key: true
    add_reference :deliveryinfos, :user, foreign_key: true
  end
end
