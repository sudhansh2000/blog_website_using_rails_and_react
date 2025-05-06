FactoryBot.define do
  factory :category do
    cat_name { Faker::Lorem.word }
  end
end

# categories,comments,likes,posts,users