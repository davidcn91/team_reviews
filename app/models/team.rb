class Team < ActiveRecord::Base
  LEAGUES = ['MLB','NFL','NBA','NHL']
  validates :location, :name, :league, :user_id, presence: true
  validates :league, inclusion: { in: LEAGUES }

  belongs_to :user
  has_many :reviews, dependent: :destroy

  paginates_per 20

  def self.search(term)
    if term
      where('name LIKE ?', "%#{term}%")
    else
      order('location, name')
    end
  end
end
