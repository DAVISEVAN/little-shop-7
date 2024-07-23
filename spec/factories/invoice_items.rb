FactoryBot.define do
    factory :invoice_item do
      quantity { Faker::Number.between(from: 1, to: 10) }
      unit_price { Faker::Number.between(from: 100, to: 10_000) }
      association :item
      association :invoice
      status { rand(0..2) }
    end
  end
  