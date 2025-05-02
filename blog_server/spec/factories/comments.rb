FactoryBot.define do
  factory :comment do
    association :user
    association :post
    # association :parent, factory: :comment
    content { Faker::Lorem.sentence(word_count: 5) }
  end
end
