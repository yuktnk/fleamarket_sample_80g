class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  
  def index
    @items = Item.includes(:item_images).order('created_at DESC')
  end

  def show
  end
  
  def new
    @item = Item.new
    @item.item_images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :explanation, item_images_attributes: [:src])
  end

end