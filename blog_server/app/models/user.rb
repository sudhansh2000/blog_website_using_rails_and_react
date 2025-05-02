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
  # has_secure_password


  validates :user_name, presence: true, uniqueness: true
  validates :email, presence: true
  validates :phone_number, presence: true, format: { with: /\A[0-9]{10}\z/, message: "must be 10 digits" }
  # validates :password, presence: true, length: { minimum: 6 }, on: create
  validates :dob, comparison: { less_than: Date.today, message: "must be in the past" }

  # default_scope { where(is_active: true) }

  before_validation :set_default_is_active

  def set_default_is_active
    self.is_active = true if self.is_active.nil?
  end
end
