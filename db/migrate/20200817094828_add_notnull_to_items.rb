class AddNotnullToItems < ActiveRecord::Migration[6.0]
  def change
    change_column_null :items, :prefecture_id, false
    change_column_null :items, :item_condition_id, false
    change_column_null :items, :delivery_fee_id, false
    change_column_null :items, :preparation_day_id, false
  end
end
