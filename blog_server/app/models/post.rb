class Post < ApplicationRecord
    belongs_to :user
    belongs_to :category
    has_many :comments, dependent: :destroy
    has_many :likes, as: :liked_on, dependent: :destroy
    has_many :bookmarks
    has_many :bookmarked_by_users, through: :bookmarks, source: :user

    has_many :share_posts
    has_many :shared_by_users, through: :share_posts, source: :sender
    has_many :shared_with_users, through: :share_posts, source: :receiver

    # default_scope { where(is_private: false) }
    scope :select_post, -> { select("posts.id, title, tags, created_at, is_private") }

    validates :title, presence: true
    validates :content, presence: true
    validates :is_private, inclusion: { in: [ true, false ] }
end
