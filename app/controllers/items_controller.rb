class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :category_parent_array, only: [:new, :create, :edit, :update]
  
  def index
    @items = Item.includes(:item_images).order('created_at DESC')
  end

  
  def new
    @item = Item.new
    @item.item_images.new
  end
  
  # 以下全て、formatはjsonのみ
  # 親カテゴリが選択された後に動くアクション
  def get_category_children
    # 選択された親カテゴリに紐づく子カテゴリの配列を取得する
    @category_children = Category.find("#{params[:parent_id]}").children
  end
  
  # 子カテゴリが選択された後に動くアクション
  def get_category_grandchildren
    # 選択された子カテゴリに紐づく孫カテゴリの配列を取得する
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end
  
  # 孫カテゴリが選択された後に動くアクション（サイズ）
  def get_size
    selected_grandchild = Category.find("#{params[:grandchild_id]}") 
    if related_size_parent = selected_grandchild.sizes[0] 
      @sizes = related_size_parent.children
    else
      selected_child = Category.find("#{params[:grandchild_id]}").parent
      if related_size_parent = selected_child.sizes[0]
        @sizes = related_size_parent.children
      end
    end
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @category_id = @item.category_id
    @category_parent = Category.find(@category_id).parent.parent
    @category_child = Category.find(@category_id).parent
    @category_grandchild = Category.find(@category_id)
  end
  
  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :explanation, :category_id, :size_id, item_images_attributes: [:src])
  end

  def category_parent_array
    @category_parent_array = Category.where(ancestry: nil)
  end
end