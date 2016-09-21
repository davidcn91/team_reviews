class Team < ActiveRecord::Base
  LEAGUES = ['MLB','NFL','NBA','NHL']
  validates :location, :name, :league, presence: true
  validates :league, inclusion: { in: LEAGUES }
end
