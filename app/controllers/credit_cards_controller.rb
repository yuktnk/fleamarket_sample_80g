class CreditCardsController < ApplicationController
  require 'payjp'
  before_action :set_card, only: [:show, :delete]


  def new
    credit_card = CreditCard.where(user_id: current_user.id)
    redirect_to action: "show" if credit_card.exists?
  end

  def pay #payjpとcreditcardのテーブル作成
    Payjp.api_key = Rails.application.credentials.pay_jp[:PAY_JP_PRIVATE_KEY]
    if params["payjp-token"].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        email: current_user.email,
        card: params["payjp-token"],
        metadata: {user_id: current_user.id}
      )
      @creditcard = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @creditcard.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end

  def delete

    if @credit_card.present?
      Payjp.api_key = Rails.application.credentials.pay_jp[:PAY_JP_PRIVATE_KEY]
      customer = Payjp::Customer.retrieve(@credit_card.customer_id)
      customer.delete
      @credit_card.delete
    end
      redirect_to action: "new"
  end

  def show

    if @credit_card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = Rails.application.credentials.pay_jp[:PAY_JP_PRIVATE_KEY]
      customer = Payjp::Customer.retrieve(@credit_card.customer_id)
      @default_card_information = customer.cards.retrieve(@credit_card.card_id)
    end
  end

  private

  def set_card
    @credit_card = CreditCard.find_by(user_id: current_user.id)
  end

end
