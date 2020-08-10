class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :family_name, :string, null: false, default: ''
    add_column :users, :first_name, :string, null: false, default: ''
    add_column :users, :family_name_furigana, :string, null: false, default: ''
    add_column :users, :first_name_furigana, :string, null: false, default: ''
    add_column :users, :birth_day, :date, null: false
    add_column :users, :postal_code, :integer, null: false
    add_column :users, :prefecture, :string, null: false, default: ''
    add_column :users, :municipalities, :string, null: false, default: ''
    add_column :users, :address, :string, null: false, default: ''
    add_column :users, :building, :string
    add_column :users, :phone_number, :string
  end
end
