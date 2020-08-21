class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :credit_card, dependent: :destroy
  # has_many :comments
  has_many :items
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  class User < ActiveRecord::Base
    has_many :bought_items, class_name: 'Item', foreign_key: 'buyer_id'
    has_many :sold_items, class_name: 'Item', foreign_key: 'seller_id'
  end
  



  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX, message: "＠とドメインを含む必要があります"}
  validates :nickname, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 7 }
  validates :family_name, presence: true, format: {with: /\A[ぁ-んァ-ン一-龥]/, message: "全角のみで入力して下さい"}
  validates :first_name, presence: true, format: {with: /\A[ぁ-んァ-ン一-龥]/, message: "全角のみで入力して下さい"}
  validates :family_name_furigana, presence: true, format: {with: /\A[ぁ-んァ-ヶー－]+\z/, message: "全角ひらがな、全角カタカナのみで入力して下さい"}
  validates :first_name_furigana, presence: true, format: {with: /\A[ぁ-んァ-ヶー－]+\z/, message: "全角ひらがな、全角カタカナのみで入力して下さい"}
  validates :birth_day, presence: true
  validates :family_name_to_deliver, presence: true
  validates :first_name_to_deliver, presence: true
  validates :family_name_to_deliver_furigana, presence: true
  validates :first_name_to_deliver_furigana, presence: true
  validates :postal_code, presence: true
  # validates :prefecture, presence: true
  validates :prefecture_id, presence: true
  validates :municipalities, presence: true
  validates :address, presence: true

  # extend ActiveHash::Associations::ActiveRecordExtensions
  # belongs_to_active_hash :prefecture
end
