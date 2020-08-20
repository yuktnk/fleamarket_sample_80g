class Item < ApplicationRecord
  has_many :item_images
  accepts_nested_attributes_for :item_images, allow_destroy: true
  
  validates_associated :item_images
  validates :item_images, presence: true
  validates :name, presence: true
  validates :explanation, presence: true
  validates :category_id, presence: true
  # brandはバリデーションなし
  validates :item_condition_id, presence: true
  validates :prefecture_id, presence: true
  validates :delivery_fee_id, presence: true
  validates :preparation_day_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  
  belongs_to :category

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :item_condition
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :preparation_day
  belongs_to_active_hash :size

  class Item < ActiveRecord::Base
    belongs_to :buyer, class_name: "User", foreign_key: "buyer_id"
    belongs_to :seller, class_name: "User", foreign_key: "seller_id"
  end

  def self.search(search)
    if search != ""
      Item.where(['name LIKE(?) or explanation LIKE(?)', "%#{search}%", "%#{search}%"])
    else
      Item.all
    end
  end
end
