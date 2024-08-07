FactoryBot.define do
  factory :coupon do
   sequence(:name) { |n| "Coupon#{n}" }
   sequence(:code) { |n| "CODE#{n}" }
   amount { 10.00 }
   discount_type { [0, 1].sample }
   status { 0 }
   association :merchant
  end
end