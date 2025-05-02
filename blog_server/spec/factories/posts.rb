FactoryBot.define do
  factory :post do
    association :user
    association :category
    title { Faker::Lorem.sentence(word_count: 3) }
    content { Faker::Lorem.paragraph(sentence_count: 2) }
    is_private { false }
    tags { [ "tag1", "tag2", "tag3" ] }
  end
end
