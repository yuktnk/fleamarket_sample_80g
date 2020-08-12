require 'rails_helper'

describe User do
  describe '#create' do

    # ニックネームが必須
    it "is invalid without a nickname" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    # メールアドレスは一意である
    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    # メールアドレスは@とドメインを含む必要がある
    it "is invalid without @" do
      user = build(:user, email: "furimafurima.com")
      user.valid?
      expect(user.errors[:email]).to include("＠とドメインを含む必要があります")
    end
    
    it "is invalid without Domain" do
      user = build(:user, email: "furima@furimafurima")
      user.valid?
      expect(user.errors[:email]).to include("＠とドメインを含む必要があります")
    end

    # パスワードが必須
    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    # パスワードは7文字以上
    it "is valid with a password that has more than 7 characters " do
      user = build(:user, password: "00000000")
      expect(user).to be_valid
    end
    it "is invalid with a password that has less than 6 characters " do
      user = build(:user, password: "aaaaaa")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end

    # パスワードは確認用を含めて2回入力する
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end


    # ユーザー本名が、名字と名前でそれぞれ必須
    it "is invalid without a family_name" do
      user = build(:user, family_name: "")
      user.valid?
      expect(user.errors[:family_name]).to include("を入力してください")
    end
    it "is invalid without a first_name" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください")
    end

    # ユーザー本名は全角で入力させる
    it "is invalid if half width（半角はエラー）" do
      user = build(:user, family_name: "ﾊﾝｶｸ")
      user.valid?
      expect(user.errors[:family_name]).to include("全角のみで入力して下さい")
    end
    it "is invalid if half width（半角はエラー）" do
      user = build(:user, first_name: "ﾊﾝｶｸ")
      user.valid?
      expect(user.errors[:first_name]).to include("全角のみで入力して下さい")
    end


    # ユーザー本名のふりがなが、名字と名前でそれぞれ必須
    it "is invalid without a family_name_furigana" do
      user = build(:user, family_name_furigana: "")
      user.valid?
      expect(user.errors[:family_name_furigana]).to include("を入力してください")
    end
    it "is invalid without a first_name_furigana" do
      user = build(:user, first_name_furigana: "")
      user.valid?
      expect(user.errors[:first_name_furigana]).to include("を入力してください")
    end

    # ユーザー本名のふりがなは全角で入力させる
    it "is invalid if half width（半角はエラー）" do
      user = build(:user, family_name_furigana: "ﾊﾝｶｸ")
      user.valid?
      expect(user.errors[:family_name_furigana]).to include("全角ひらがな、全角カタカナのみで入力して下さい")
    end
    it "is invalid if half width（半角はエラー）" do
      user = build(:user, first_name_furigana: "ﾊﾝｶｸ")
      user.valid?
      expect(user.errors[:first_name_furigana]).to include("全角ひらがな、全角カタカナのみで入力して下さい")
    end

    # 生年月日が必須
    it "is invalid without a birth_day" do
      user = build(:user, birth_day: "")
      user.valid?
      expect(user.errors[:birth_day]).to include("を入力してください")
    end

    # 送付先氏名が、名字と名前でそれぞれ必須
    it "is invalid without a family_name_to_deliver" do
      user = build(:user, family_name_to_deliver: "")
      user.valid?
      expect(user.errors[:family_name_to_deliver]).to include("を入力してください")
    end
    it "is invalid without a first_name_to_deliver" do
      user = build(:user, first_name_to_deliver: "")
      user.valid?
      expect(user.errors[:first_name_to_deliver]).to include("を入力してください")
    end


    # 送付先氏名のふりがなが、名字と名前でそれぞれ必須
    it "is invalid without a family_name_to_deliver_furigana" do
      user = build(:user, family_name_to_deliver_furigana: "")
      user.valid?
      expect(user.errors[:family_name_to_deliver_furigana]).to include("を入力してください")
    end
    it "is invalid without a first_name_to_deliver_furigana" do
      user = build(:user, first_name_to_deliver_furigana: "")
      user.valid?
      expect(user.errors[:first_name_to_deliver_furigana]).to include("を入力してください")
    end

    # 郵便番号が必須
    it "is invalid without a postal_code" do
      user = build(:user, postal_code: "")
      user.valid?
      expect(user.errors[:postal_code]).to include("を入力してください")
    end

    # 都道府県が必須
    it "is invalid without a prefecture" do
      user = build(:user, prefecture: "")
      user.valid?
      expect(user.errors[:prefecture]).to include("を入力してください")
    end

    # 市区町村が必須
    it "is invalid without a municipalities" do
      user = build(:user, municipalities: "")
      user.valid?
      expect(user.errors[:municipalities]).to include("を入力してください")
    end

    # 番地が必須
    it "is invalid without a address" do
      user = build(:user, address: "")
      user.valid?
      expect(user.errors[:address]).to include("を入力してください")
    end

# マンション名やビル名、そしてその部屋番号は任意
# お届け先の電話番号は任意
  end
end