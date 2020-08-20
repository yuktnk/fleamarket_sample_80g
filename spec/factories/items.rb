FactoryBot.define do

  factory :item do
    name                        {"あいてむ"}
    explanation                 {"いいあいてむだよ"}
    price                       {"400"}
    prefecture_id               {"1"}
    item_condition_id           {"1"}
    delivery_fee_id             {"1"}
    preparation_day_id          {"1"}
    size_id                     {"1"}
  end

end