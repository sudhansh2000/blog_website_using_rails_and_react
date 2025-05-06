FactoryBot.define do
  factory :category_preference do
    association :user
    association :category
  end
end
