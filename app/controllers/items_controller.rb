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
    # セレクトボックスの初期値設定
    @category_parent_array = ["選択してください"]
    # データベースから親カテゴリのみ抽出して配列にする
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.category
    end
  end

  # 以下全て、formatはjsonのみ
  # 親カテゴリが選択された後に動くアクション
  def get_category_children
    # 選択された親カテゴリに紐づく子カテゴリの配列を取得する
    @category_children = Category.find_by(category: "#{params[:parent_category]}", ancestry: nil).children
  end

  # 子カテゴリが選択された後に動くアクション
  def get_category_grandchildren
    # 選択された子カテゴリに紐づく孫カテゴリの配列を取得する
    @category_grandchildren = Category.find("#{params[:child_id]}").children
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