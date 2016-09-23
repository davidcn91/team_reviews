class AddVoteToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :vote, :integer, default: 0, null: false
  end
end
