class UsersController < ApplicationController
  def index
    @listed_items = Item.where(seller_id: current_user.id).includes(:item_images).includes(:comments)
  end

  def sold_items
    @sold_items = Item.where(seller_id: current_user.id).includes(:item_images).includes(:comments)
  end

  def show
  end

end
