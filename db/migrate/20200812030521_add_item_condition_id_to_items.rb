class AddItemConditionIdToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :item_condition_id, :integer
  end
end
