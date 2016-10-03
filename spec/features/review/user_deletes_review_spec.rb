require 'rails_helper'
require 'pry'

feature 'user deletes review', %Q{
  As an authenticated user
  I want to delete a review
  So that no one can view it
} do

  # * If I am the creator of a review, I should be able to destroy the Review.
  # * If I am not the creator of the team, I should not be able to destroy the Team.
  # * If I am not the creator of the review or am not signed in and try to destroy
  #   the review, I should receive an error message.

  before(:each) do
    @user = FactoryGirl.create(:user)
    @team = FactoryGirl.create(:team, user_id: @user.id)
    @review = FactoryGirl.create(:review, user_id: @user.id, team_id: @team.id)
    Vote.create(user_id: @user.id, review_id: @review.id)
  end

  scenario 'signed in user is the creator of the review' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    click_link "#{@team.location} #{@team.name} (#{@team.league})"

    click_button 'Delete Review'
    expect(page).to have_content("Review deleted successfully.")
    expect(page).to have_content("Reviews")
    expect(page).to_not have_content(@review.body)
    expect(page).to_not have_content(@review.rating)
  end

  scenario 'user is not signed in' do
    visit root_path
    click_link "#{@team.location} #{@team.name} (#{@team.league})"

    expect(page).to_not have_content("Delete Team")
  end

  scenario 'signed in user is not creator of the team' do
    user_2 = FactoryGirl.create(:user)
    Vote.create(user_id: user_2.id, review_id: @review.id)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user_2.email
    fill_in 'Password', with: user_2.password
    click_button 'Sign In'
    click_link "#{@team.location} #{@team.name} (#{@team.league})"

    expect(page).to_not have_content("Delete Team")
  end
end
