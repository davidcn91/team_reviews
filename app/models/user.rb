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

  paginates_per 20

  def admin?
    role == "admin"
  end

  private
  def profile_photo_size_validation
    errors[:profile_photo] << "should be less than 500KB" if profile_photo.size > 0.5.megabytes
  end
end
