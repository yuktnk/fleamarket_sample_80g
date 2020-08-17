class AddAncestryToSize < ActiveRecord::Migration[6.0]
  def change
    add_column :sizes, :ancestry, :string
    add_index :sizes, :ancestry
  end
end
