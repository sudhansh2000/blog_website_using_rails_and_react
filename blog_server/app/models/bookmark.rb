class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :post

  scope :select_post, -> { select("posts.id, title, tags, bookmarks.created_at, is_private") }
end
