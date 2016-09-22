require 'rails_helper'
require 'pry'

feature 'user updates review', %Q{
  As an authenticated user
  I want to update an review
  So that I can correct errors or provide new information
} do

  # * If I am the creator of a review, I should be able to update the Review.
  # * If I specify valid Review information, the Review should be updated.
  # * If I do not specify valid Review information, the Review should not be updated
  #   and I should be provided an error message.
  # * If I am not signed in, I should not be able to update the Review and should
  #   be notified that I am not signed in.
  # * If I am not the creator of the review, I should not be able to update the Review
  #   and should be notified that I am not authorized to update it.
  before(:each) do
    @user = FactoryGirl.create(:user)
    @team = FactoryGirl.create(:team, user_id: @user.id)
    @review = FactoryGirl.create(:review, user_id: @user.id, team_id: @team.id)
  end

  scenario 'creator supplies valid information' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    expect(page).to have_content("Home")
    click_link "#{@team.location} #{@team.name} (#{@team.league})"

    click_link "Edit Review"
    fill_in 'Body', with: 'New Review New Review New Review New Review'
    click_button 'Submit Review'

    expect(page).to have_content("New Review New Review New Review New Review")
    expect(page).to_not have_content(@review.body)
    expect(page).to have_content("Reviews")
  end

  scenario 'creator supplies invalid information' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    expect(page).to have_content("Home")
    click_link "#{@team.location} #{@team.name} (#{@team.league})"

    click_link "Edit Review"
    fill_in 'Body', with: 'Too short'
    click_button 'Submit Review'

    expect(page).to_not have_content("New Review New Review New Review New Review")
    expect(page).to have_content("Review length must be 30 characters or greater")
  end

  scenario 'user is not signed in' do
    visit root_path
    click_link "#{@team.location} #{@team.name} (#{@team.league})"
    expect(page).to_not have_link("Edit Review")

    visit edit_team_review_path(@team.id, @review.id)
    fill_in 'Body', with: 'New Review New Review New Review New Review'
    click_button 'Submit Review'

    expect(page).to have_content("You must be signed in to update a review.")
    expect(page).to have_content("Reviews")
  end

  scenario 'authenticated user is not the creator of the team' do
    user_2 = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user_2.email
    fill_in 'Password', with: user_2.password
    click_button 'Sign In'
    click_link "#{@team.location} #{@team.name} (#{@team.league})"

    expect(page).to_not have_content("Edit Review")

    visit edit_team_review_path(@team.id, @review.id)
    fill_in 'Body', with: 'New Review New Review New Review New Review'
    click_button 'Submit Review'

    expect(page).to have_content("You must be the creator of a review to update it.")
    expect(page).to have_content("Reviews")
  end

end
