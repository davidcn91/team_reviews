class Review < ActiveRecord::Base
  RATINGS = ['',1,2,3,4,5,6,7,8,9,10]

  belongs_to :user
  belongs_to :team
  has_many :votes

  validates :team_id, :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :body, presence: true, length: {minimum: 30}
  validates :rating, numericality:
  { allow_blank: true, only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
end
