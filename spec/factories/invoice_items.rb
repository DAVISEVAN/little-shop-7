FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.between(from: 1, to: 10) }
    unit_price { Faker::Number.between(from: 100, to: 10_000) }
    status { 'packaged' }
    association :item
    association :invoice
  end
end
