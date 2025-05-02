FactoryBot.define do
  factory :like do
    association :user
    association :likeable, factory: :comment
    association :likeable, factory: :post
  end
end
