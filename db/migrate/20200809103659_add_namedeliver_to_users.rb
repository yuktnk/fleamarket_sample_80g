class AddNamedeliverToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :family_name_to_deliver, :string, null: false, default: ''
    add_column :users, :first_name_to_deliver, :string, null: false, default: ''
  end
end
