require 'rails_helper'
describe Item do
  describe '.search' do
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