FactoryBot.define do
  factory :share_post do
    association :sender, factory: :user
    association :receiver, factory: :user
    association :post
  end
end
