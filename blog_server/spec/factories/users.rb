
FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    user_name { Faker::Internet.username }
    email { Faker::Internet.email }
    phone_number { Faker::Number.number(digits: 10).to_s }
    password { "password123" }
    dob { Date.new(1990, 1, 1) }
    is_active { true }
  end
end
