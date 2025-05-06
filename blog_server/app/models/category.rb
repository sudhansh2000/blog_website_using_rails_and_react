class Category < ApplicationRecord
    has_many :posts
    has_many :category_preferences
    has_many :users, through: :category_preferences
end
