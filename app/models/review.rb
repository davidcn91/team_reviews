class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  validates :team_id, :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :body, presence: true, length: {minimum: 30}
end
