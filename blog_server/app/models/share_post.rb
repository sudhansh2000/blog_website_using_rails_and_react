class SharePost < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :post

  validates :post_id, uniqueness: { scope: [:sender_id, :receiver_id], message: "has already been shared with this receiver by this sender" }
end
