class ItemImage < ApplicationRecord
  mount_uploader :src, ImageUploader
  belongs_to :item, optional: true, dependent: :destroy
  validates :src, presence: true
end
