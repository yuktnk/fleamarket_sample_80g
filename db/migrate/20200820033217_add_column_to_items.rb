class AddColumnToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :seller_id, :integer
    add_column :items, :buyer_id, :integer
  end
end
