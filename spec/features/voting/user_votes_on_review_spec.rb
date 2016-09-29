require 'rails_helper'
require 'pry'

feature 'user votes on review', %Q{
  As an authenticated user
  I want to vote on a review for a team
  So that others can view a review's rating
} do

  # * If I am logged in, I should be able to like or dislike any review.
  # * If I vote 'Like', the rating should increase by 1.
  # * If I vote 'Dislike', the rating should decrease by 1.
  # * I should only be able to vote +1 or -1.
  # * When I vote 'Like', the 'Like' button should disappear so I can't click it again.
  # * When I vote 'Dislike', the 'Dislike' button should disappear so I can't click it again.
  # * If I am not logged in, I should not be able to vote.

  before(:each) do
    @user = FactoryGirl.create(:user)
    @team = FactoryGirl.create(:team, user_id: @user.id)
    @review = FactoryGirl.create(:review, user_id: @user.id, team_id: @team.id)
    @vote = Vote.create(user_id: @user.id, review_id: @review.id)
  end

  scenario 'user is not signed in' do
    visit root_path
    click_link "#{@team.location} #{@team.name} (#{@team.league})"

    expect(page).to_not have_button("Like Review")
    expect(page).to_not have_button("Dislike Review")
  end

  # scenario 'authenticated user votes on a review' do
  #   visit root_path
  #   click_link 'Sign In'
  #   fill_in 'Email', with: @user.email
  #   fill_in 'Password', with: @user.password
  #   click_button 'Sign In'
  #   click_link "#{@team.location} #{@team.name} (#{@team.league})"
  #
  #   click_button 'Like Review'
  #   visit team_path(@team.id)
  #   expect(page).to have_content("Review Rating: 1")
  #   expect(page).to_not have_button("Like Review")
  #   expect(page).to have_button("Dislike Review")
  #
  #   click_button 'Dislike Review'
  #   visit team_path(@team.id)
  #   expect(page).to have_content("Review Rating: 0")
  #   expect(page).to have_button("Like Review")
  #   expect(page).to have_button("Dislike Review")
  #
  #   click_button 'Dislike Review'
  #   visit team_path(@team.id)
  #   expect(page).to have_content("Review Rating: -1")
  #   expect(page).to have_button("Like Review")
  #   expect(page).to_not have_button("Dislike Review")
  # end

end
