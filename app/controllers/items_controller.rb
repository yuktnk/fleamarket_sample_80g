class ItemsController < ApplicationController
  require 'payjp'
  before_action :set_card, only: [:purchase, :pay, :done]

  before_action :move_to_index, except: [:index, :show, :search]
  before_action :category_parent_array, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :destroy, :purchase, :done, :edit, :update]
  
  def index
    @items = Item.includes(:item_images).limit(3).order('created_at DESC')
    # レディース新着アイテムとメンズ新着アイテム
    @ladies_items = Item.where(category: 159..346).includes(:item_images).limit(3).order("created_at DESC")
    @mens_items = Item.where(category: 347..476).includes(:item_images).limit(3).order("created_at DESC")
  end
  
  def new
    @item = Item.new
    @item.item_images.new
  end

  def purchase
    #テーブルからpayjpの顧客IDを検索
    if @credit_card.blank?
      #登録された情報がない場合にカード登録画面に移動する
      redirect_to controller: "credit_cards", action: "new"
    else
      Payjp.api_key = Rails.application.credentials.pay_jp[:PAY_JP_PRIVATE_KEY]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@credit_card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(@credit_card.card_id)
    end
  end

  def pay

    @item = Item.find(params[:id])
    Payjp.api_key = Rails.application.credentials.pay_jp[:PAY_JP_PRIVATE_KEY]
    Payjp::Charge.create(
    amount: @item.price, #支払金額を入力（itemテーブル等に紐づけても良い）
    customer: @credit_card.customer_id, #顧客ID
    currency:'jpy'
  )
  @item.update!(buyer_id: current_user.id)
  redirect_to action: 'done' #完了画面に移動
  end

  def done
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
      flash[:notice] = "商品を出品しました"
    else
      render :new
    end
  end

  def edit
    @category_grandchild = @item.category
    @category_child = @category_grandchild.parent
    @category_parent = @category_child.parent
    @size = @item.size
    # カテゴリー一覧を作成
    @category = Category.find(params[:id])
    # 紐づく孫カテゴリーの親（子カテゴリー）の一覧を配列で取得
    @category_children = @item.category.parent.parent.children
    # 紐づく孫カテゴリーの一覧を配列で取得
    @category_grandchildren = @item.category.parent.children
    # サイズ自体が存在しているかどうか
    if @item.size_id.present?
      @sizes = @item.size.parent.children
    end
    @images = ItemImage.where(item_id: params[:id])
  end

  def show
    @item_images = @item.item_images
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
    @category_grandchild = @item.category
    @category_child = @category_grandchild.parent
    @category_parent = @category_child.parent
  end

  def update
    # updateアクションの前でないとうまく動作しない
    # 編集画面で選択された新しいカテゴリー
    @category_grandchild = Category.find(item_params[:category_id])
    @category_child = @category_grandchild.parent
    @category_parent = @category_child.parent
    # sizeがあるかどうか？なければnilを入れる
    if @category_grandchild.sizes.present?
      @item.size_id = @category_grandchild.sizes[0].id
    else
      @item.size = nil
    end

    @size = @item.size
    # カテゴリー一覧を作成
    # @category = Category.find(params[:id])
    # @category = Category.find(item_params[:category_id])
    # 紐づく孫カテゴリーの親（子カテゴリー）の一覧を配列で取得
    @category_children = @item.category.parent.parent.children
    # 紐づく孫カテゴリーの一覧を配列で取得
    @category_grandchildren = @item.category.parent.children
    # サイズ自体が存在しているかどうか
    if @item.size_id.present?
      if @item.size.ancestry.present?
        @sizes = @item.size.parent.children
      else
        @sizes = nil
      end
    else
      @sizes = nil
    end

    # binding.pry
    if @item.update(item_params)
      redirect_to root_path
      flash[:notice] = "商品を編集しました"
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = "商品の編集に失敗しました"
    end
  end

  def search
    @search_items = Item.search(params[:key])
  end

  def destroy
    if @item.destroy
      redirect_to root_path
      flash[:notice] = "商品を削除しました"
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = "商品の削除に失敗しました"
    end
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :explanation, :category_id, :size_id, :item_condition_id, :prefecture_id, :delivery_fee_id, :preparation_day_id, item_images_attributes: [:src, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def category_parent_array
    @category_parent_array = Category.where(ancestry: nil)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_card
    # binding.pry
    @credit_card = CreditCard.find_by(user_id: current_user.id)
  end

end