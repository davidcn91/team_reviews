class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :review_id, :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :score, numericality:
  { only_integer: true, greater_than_or_equal_to: -1, less_than_or_equal_to: 1 }
end
