FactoryBot.define do
  factory :user do
    nickname                         {"ふりまちゃん"}
    email                            {"kkk@gmail.com"}
    password                         {"00000000"}
    password_confirmation            {"00000000"}
    family_name                      {"田中"}
    first_name                       {"裕輝"}
    family_name_furigana             {"たなか"}
    first_name_furigana              {"ゆうき"}
    birth_day                        {"1900-05-31"}
    family_name_to_deliver           {"田中"}
    first_name_to_deliver            {"裕輝"}
    family_name_to_deliver_furigana  {"たなか"}
    first_name_to_deliver_furigana   {"ゆうき"}
    postal_code                      {"0002222"}
    prefecture_id                    {"15"}
    municipalities                   {"戸田市"}
    address                          {"上戸田うん丁目"}
    building                         {"マンション田中101"}
    phone_number                     {"09012341234"}
  end
end