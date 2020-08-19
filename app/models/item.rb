class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :item_condition
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :preparation_day
  belongs_to_active_hash :size

  def self.search(search)
    if search != ""
      Item.where('name LIKE(?)', "%#{search}")
    else
      Item.all
    end
  end
end
