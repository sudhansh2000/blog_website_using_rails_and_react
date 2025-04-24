class Post < ApplicationRecord
    belongs_to :user
    belongs_to :category
    has_many :comments, dependent: :destroy
    has_many :likes, as: :liked_on, dependent: :destroy

    validates :title, presence: true
    validates :content, presence: true
    validates :is_private, inclusion: { in: [ true, false ] }
end
