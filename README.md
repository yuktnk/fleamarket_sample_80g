# READ ME

## credit_cards
| Column      | Type       | Options                       |
| ----------- | ---------- | ----------------------------- |
| card_id     | string     | null:false                    |
| customer_id | string     | null:false                    |
| user_id     | references | null:false, foreign_key: true |
### Association
- belongs_to :user


## comments
| Column  | Type       | Options                       |
| ------- | ---------- | ----------------------------- |
| text    | text       | null:false                    |
| user_id | references | null:false, foreign_key: true |
| item_id | references | null:false, foreign_key: true |
### Association
- belongs_to :user
- belongs_to :item


## users テーブル
| Column                          | Type    | Options                                |
| ------------------------------- | ------- | -------------------------------------- |
| nickname                        | string  | index: true, null: false, unique: true |
| email                           | string  | index: true, null: false, unique: true |
| encrypted_password              | string  | null: false                            |
| family_name                     | string  | null: false                            |
| first_name                      | string  | null: false                            |
| family_name_furigana            | string  | null: false                            |
| first_name_furigana             | string  | null: false                            |
| birth_day                       | date    | null: false                            |
| family_name_to_deliver          | string  | null: false                            |
| first_name_to_deliver           | string  | null: false                            |
| family_name_to_deliver_furigana | string  | null: false                            |
| first_name_to_deliver_furigana  | string  | null: false                            |
| postal_code                     | integer | null: false                            |
| prefecture_id                   | integer |                                        | (active_hash) |
| municipalities                  | string  | null: false                            |
| address                         | string  | null: false                            |
| building                        | string  |                                        |
| phone_number                    | string  |                                        |
### Association
- has_many :bought_item, foreign_key: "seller_id", class_name: "Item"
- has_many :sold_item, foreign_key: "buyer_id", class_name: "Item"
- has_many :comments
- has_many :items
- has_one :credit_card, dependent: :destroy
- belongs_to_active_hash: prefecture
<!-- 
- has_many :points, dependent: :destroy
- has_many :likes, through: :likes
- has_many :orders
- has_many :user_evaluations, dependent: :destroy
- has_many :news, dependent: :destroy
 -->



## categories テーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| category | string | null: false |
| ancestry | string |             |
### Association
- has_many :items
- has_many :category_sizes
- has_many :sizes, through: :category_sizes


## sizes テーブル
| Column   | Type   | Options |
| -------- | ------ | ------- |
| size     | string |         |
| ancestry | string |         |
### Association
- has_many :items
- has_many :category_sizes
- has_many :categories, through: :category_sizes
- has_ancestry


## category_sizes テーブル
| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| size_id     | references | null: false, foreign_key: true |
| category_id | references | null: false, foreign_key: true |
### Association
- belongs_to :category
- belongs_to :size


## brands テーブル
| Column | Type   | Options |
| ------ | ------ | ------- |
| name   | string |         |
### Association
- has_many :items




## items テーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| name               | string     | null: false                    |
| explanation        | text       | null: false                    |
| price              | integer    | null: false                    |
| category_id        | references | null: false, foreign_key: true |
| seller_id          | integer    |                                |
| buyer_id           | integer    |                                |
| item_condition_id  | integer    |                                | (active_hash) |
| delivery_fee_id    | integer    |                                | (active_hash) |
| preparation_day_id | integer    |                                | (active_hash) |
| prefecture_id      | integer    |                                | (active_hash) |
| size_id            | integer    |                                | (active_hash) |
### Association
- belongs_to :user
- belongs_to :category
- has_many :item_images, dependent: :destroy
- has_many :comments, dependent: :destroy
- belongs_to_active_hash :item_condition
- belongs_to_active_hash :delivery_fee
- belongs_to_active_hash :preparation_day
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :size
<!--
- has_one :user_evaluation
- has_one :order
- has_many :likes, through: :likes
-->

## item_images テーブル
| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| item_id | references | null: false, foreign_key: true |
| src     | string     | null: false                    |
### Association
- belongs_to :item





# active_hash


## item_conditions テーブル(active_hash)
| Column    | Type   | Options     |
| --------- | ------ | ----------- |
| condition | string | null: false |
### Association
- has_many :items


## delivery_fees テーブル(active_hash)
| Column       | Type   | Options     |
| ------------ | ------ | ----------- |
| delivery_fee | string | null: false |
### Association
- has_many :items


## preparation_days テーブル(active_hash)
| Column          | Type   | Options     |
| --------------- | ------ | ----------- |
| preparation_day | string | null: false |
### Association
- has_many :items


## prefectures テーブル(active_hash)
| Column     | Type   | Options     |
| ---------- | ------ | ----------- |
| prefecture | string | null: false |
### Association
- has_many :items
- has_many :users


## sizes テーブル(active_hash)
| Column | Type   | Options     |
| ------ | ------ | ----------- |
| size   | string | null: false |
### Association
- has_many :items
- has_many :category_sizes
- has_many :categories, through: :category_sizes




<!-- 以下は未実装のため非表示にします --


## ordersテーブル
|Column|Type|Options|
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |
### Association
- belongs_to :user
- belongs_to :item 


## points
| Column  | Type       | Options                       |
| ------- | ---------- | ----------------------------- |
| point   | integer    |                               |
| user_id | references | null:false, foreign_key: true |
### Association
- belongs_to :user


## user_evaluations テーブル
| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user_id       | references | null: false, foreign_key: true |
| item_id       | references | null: false, foreign_key: true |
| evaluation_id | integer    |                                | (active_hash) |
| review        | text       |                                |
### Association
- belongs_to :user
- belongs_to :item
- belongs_to_active_hash :evaluation


## todos
| Column  | Type       | Options                       |
| ------- | ---------- | ----------------------------- |
| user_id | references | null:false, foreign_key: true |
| text    | text       | null:false                    |
### Association
- belongs_to :user


## news テーブル（不可算名詞）
| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| title   | string     | null: false                    |
| text    | text       | null: false                    |
| user_id | references | null: false, foreign_key: true |
### Association
- belongs_to :user


## likes テーブル
| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |
### Association
- belongs_to :user
- belongs_to :item


## evaluations テーブル(active_hash)
| Column     | Type   | Options     |
| ---------- | ------ | ----------- |
| evaluation | string | null: false |
### Association
- has_many :user_evaluations


-- 未実装のため非表示ここまで -->