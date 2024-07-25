FactoryBot.define do
  factory :invoice do
    status { 'in progress' }
    association :customer
  end
end
