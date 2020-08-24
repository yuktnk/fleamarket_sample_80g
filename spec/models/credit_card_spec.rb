require 'rails_helper'

describe CreditCard do
  describe '#pay' do
    #カードIDが必須
    it "is invalid without card_id" do
      credit_card = build(:credit_card, card_id: "")
      credit_card.valid?
      expect(credit_card.errors[:card_id]).to include("を入力してください")
    end

    #顧客IDが必須
    it "is invalid without customer_id" do
      credit_card = build(:credit_card, customer_id: "")
      credit_card.valid?
      expect(credit_card.errors[:customer_id]).to include("を入力してください")
    end
  
  end

end