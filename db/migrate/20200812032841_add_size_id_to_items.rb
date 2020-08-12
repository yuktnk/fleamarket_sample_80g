class AddSizeIdToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :size_id, :integer
  end
end
