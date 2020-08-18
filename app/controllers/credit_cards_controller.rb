class CreditCardsController < ApplicationController

  require 'payjp'

  def new
    creditcard = CreditCard.where(user_id: current_user.id)
    redirect_to action: "show" if creditcard.exists?
  end

  def pay #payjpとcreditcardのテーブル作成
    Payjp.api_key = ["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        email: current_user.email,
        card: params['payjp-token'],
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
    creditcard = CreditCard.where(user_id: current_user.id).first
    if creditcard.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(creditcard.customer_id)
      customer.delete
      creditcard.delete
    end
      redirect_to action: "new"
  end

  def show
    creditcard = CreditCard.where(user_id: current_user.id).first
    if creditcard.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(creditcard.customer_id)
      @default_card_information = customer.cards.retrieve(creditcard.card_id)
    end
  end
end
