class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_confirmation_of :password
  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: true

  has_many :teams
  has_many :reviews
  has_many :votes

  mount_uploader :profile_photo, ProfilePhotoUploader

  def admin?
    role == "admin"
  end
end
