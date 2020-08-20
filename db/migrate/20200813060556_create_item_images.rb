class CreateItemImages < ActiveRecord::Migration[6.0]
  def change
    create_table :item_images do |t|
      t.string :src
      t.references :item, foreign_key: true
      t.timestamps
    end
  end
end
