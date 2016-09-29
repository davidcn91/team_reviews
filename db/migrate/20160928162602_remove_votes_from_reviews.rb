class RemoveVotesFromReviews < ActiveRecord::Migration[5.0]
  def change
    remove_column :reviews, :vote, :integer
  end
end
