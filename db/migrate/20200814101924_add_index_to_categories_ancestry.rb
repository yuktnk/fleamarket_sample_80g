class AddIndexToCategoriesAncestry < ActiveRecord::Migration[6.0]
  def change
    add_index :categories, :ancestry
  end
end
