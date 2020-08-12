class AddPreparationDayIdToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :preparation_day_id, :integer
  end
end
