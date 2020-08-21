require 'rails_helper'
describe Item do

  describe '#create' do

    # 商品の名前が必須
    it "is invalid without a name" do
      item = build(:item, name: "")
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    # 商品の説明が必須
    it "is invalid without a explanation" do
      item = build(:item, explanation: "")
      item.valid?
      expect(item.errors[:explanation]).to include("を入力してください")
    end

    # 商品のカテゴリが必須
    it "is invalid without a category_id" do
      item = build(:item, category_id: "")
      item.valid?
      expect(item.errors[:category_id]).to include("を入力してください")
    end

    # 商品のブランドが任意
    
    # 商品の状態が必須
    it "is invalid without a item_condition_id" do
      item = build(:item, item_condition_id: "")
      item.valid?
      expect(item.errors[:item_condition_id]).to include("を入力してください")
    end

    # 商品の配送料が必須
    it "is invalid without a delivery_fee_id" do
      item = build(:item, delivery_fee_id: "")
      item.valid?
      expect(item.errors[:delivery_fee_id]).to include("を入力してください")
    end

    # 商品の配送先が必須
    it "is invalid without a prefecture_id" do
      item = build(:item, prefecture_id: "")
      item.valid?
      expect(item.errors[:prefecture_id]).to include("を入力してください")
    end

    # 商品の発送日数が必須
    it "is invalid without a preparation_day_id" do
      item = build(:item, preparation_day_id: "")
      item.valid?
      expect(item.errors[:preparation_day_id]).to include("を入力してください")
    end

    # 商品の価格が必須
    it "is invalid without a price" do
      item = build(:item, price: "")
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

  end

  describe '#search' do
    it "keyがない場合、全ての商品レコードは表示できる" do
      item = create(:item)
      key = ""
      expect(described_class.search(key).length).to eq 1
    end
    it "商品名に一致するレコードを検索できること" do
      item = create(:item, name: "ロボット")
      key = "ロボ"
      expect(described_class.search(key).length).to eq 1
    end
    it "商品名に一致しないレコードは検索できないこと" do
      item = create(:item, name: "ロボット")
      key = "robo"
      expect(described_class.search(key).length).to eq 0
    end
    it "商品説明に一致するレコードを検索できること" do
      item = create(:item, explanation: "ロボです")
      key = "ロボ"
      expect(described_class.search(key).length).to eq 1
    end
    it "商品説明に一致しないレコードは検索できないこと" do
      item = create(:item, explanation: "ロボです")
      key = "robo"
      expect(described_class.search(key).length).to eq 0
    end
  end


end