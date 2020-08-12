class AddDeliveryFeeIdToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :delivery_fee_id, :integer
  end
end
