class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :category_preferences
  has_many :preferred_categories, through: :category_preferences, source: :category
  has_many :bookmarks
  has_many :bookmarked_posts, through: :bookmarks, source: :post

  has_many :sent_share_posts, class_name: "SharePost", foreign_key: :sender_id
  has_many :shared_posts, through: :sent_share_posts, source: :post

  # Posts this user has received from others
  has_many :received_share_posts, class_name: "SharePost", foreign_key: :receiver_id
  has_many :received_posts, through: :received_share_posts, source: :post
  # has_secure_password


  validates :user_name, presence: true, uniqueness: true
  validates :email, presence: true
  validates :phone_number, presence: true, format: { with: /\A[0-9]{10}\z/, message: "must be 10 digits" }
  validates :dob, comparison: { less_than: Date.today, message: "must be in the past" }

  default_scope { where(is_active: true) }
end
