class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    belongs_to :comment, optional: true

    # has_many :comments, class_name: "Comment", foreign_key: "comment_id", dependent: :destroy
    has_many :replies, class_name: "Comment", foreign_key: "parent_id"
    belongs_to :parent, class_name: "Comment", optional: true
    has_many :likes, as: :liked_on, dependent: :destroy

    validates :content, presence: true
end
