class PurchasesController < ApplicationController

  require 'payjp'
  before_action :set_card, only: [:index, :pay]

  def new
  end

  def index
    # credit_card = CreditCard.where(user_id: current_user.id).first
    #テーブルからpayjpの顧客IDを検索
    if @credit_card.blank?
      #登録された情報がない場合にカード登録画面に移動する
      redirect_to controller: "credit_cards", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@credit_card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(@credit_card.card_id)
    end
  end

  def pay
    # credit_card = CreditCard.where(user_id: current_user.id).first
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    Payjp::Charge.create(
    :amount => 13500, #支払金額を入力（itemテーブル等に紐づけても良い）
    :customer => @credit_card.customer_id, #顧客ID
    :currency => 'jpy'
  )
  redirect_to action: 'done' #完了画面に移動
  end

  private

  def set_card
    @credit_card = CreditCard.find_by(user_id: current_user.id)
  end

end
