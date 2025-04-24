class Like < ApplicationRecord
    belongs_to :user
    belongs_to :liked_on, polymorphic: true
    # //validate that only one user can like a post or comment
    validates :user_id, uniqueness: { scope: [ :liked_on_id, :liked_on_type ], message: "has already liked this post/comment" }
end
