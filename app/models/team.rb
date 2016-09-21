class Team < ActiveRecord::Base
  LEAGUES = ['MLB','NFL','NBA','NHL']
  validates :location, :name, :league, :user_id, presence: true
  validates :league, inclusion: { in: LEAGUES }

  belongs_to :user
end
