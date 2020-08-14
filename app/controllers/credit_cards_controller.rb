class CreditCardsController < ApplicationController

  require 'payjp'

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to action: "show" if card.exists?
  end
end
