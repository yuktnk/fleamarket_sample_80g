class CreateCategorySizes < ActiveRecord::Migration[6.0]
  def change
    create_table :category_sizes do |t|
      t.references :category
      t.references :size

      t.timestamps
    end
  end
end
