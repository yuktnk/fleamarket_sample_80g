require 'rails_helper'
describe ItemImage do

  describe '#create' do

    # 商品の画像が必須
    it "is invalid without a item_image" do
      item_image = build(:item_image, src: "")
      item_image.valid?
      expect(item_image.errors[:src]).to include("を入力してください")
    end

  end
end