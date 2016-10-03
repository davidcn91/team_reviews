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
  # * If I do not specify a rating, I should not receive an error
  #   and my review should still be submitted without a rating.
  # * If I am not signed in, I should not be able to update the Review
  # * If I am not the creator of the review, I should not be able to update the Review


  before(:each) do
    @user = FactoryGirl.create(:user)
    @team = FactoryGirl.create(:team, user_id: @user.id)
    @review = FactoryGirl.create(:review, user_id: @user.id, team_id: @team.id)
    Vote.create(user_id: @user.id, review_id: @review.id)
  end

  scenario 'creator supplies valid information' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    expect(page).to have_content("Professional Sports Team Reviews")
    click_link "#{@team.location} #{@team.name} (#{@team.league})"

    click_link "Edit Review"
    fill_in 'Body', with: 'New Review New Review New Review New Review'
    select 7, from: 'Rate Team (1-10)'
    click_button 'Submit Review'

    expect(page).to have_content("New Review New Review New Review New Review")
    expect(page).to_not have_content(@review.body)
    expect(page).to have_content("7")
    expect(page).to_not have_content(@review.rating)
    expect(page).to have_content("Reviews")
  end

  scenario 'creator supplies review body but does not provide rating' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    expect(page).to have_content("Professional Sports Team Reviews")
    click_link "#{@team.location} #{@team.name} (#{@team.league})"

    click_link "Edit Review"
    fill_in 'Body', with: 'New Review New Review New Review New Review'
    select '', from: 'Rate Team (1-10)'
    click_button 'Submit Review'

    expect(page).to have_content("New Review New Review New Review New Review")
    expect(page).to_not have_content(@review.body)
    expect(page).to_not have_content(@review.rating)
    expect(page).to_not have_content('Team Rating')
    expect(page).to have_content("Reviews")
  end

  scenario 'creator supplies invalid information' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    expect(page).to have_content("Professional Sports Team Reviews")
    click_link "#{@team.location} #{@team.name} (#{@team.league})"

    click_link "Edit Review"
    fill_in 'Body', with: 'Too short'
    select @review.rating, from: 'Rate Team (1-10)'
    click_button 'Submit Review'

    expect(page).to_not have_content("New Review New Review New Review New Review")
    expect(page).to have_content("Review length must be 30 characters or greater")
  end

  scenario 'user is not signed in' do
    visit root_path
    click_link "#{@team.location} #{@team.name} (#{@team.league})"
    expect(page).to_not have_link("Edit Review")

    expect{visit edit_team_review_path(@team.id, @review.id)}.to raise_error(ActionController::RoutingError)
  end

  scenario 'authenticated user is not the creator of the team' do
    user_2 = FactoryGirl.create(:user)
    Vote.create(user_id: user_2.id, review_id: @review.id)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user_2.email
    fill_in 'Password', with: user_2.password
    click_button 'Sign In'
    click_link "#{@team.location} #{@team.name} (#{@team.league})"

    expect(page).to_not have_content("Edit Review")
    expect{visit edit_team_review_path(@team.id, @review.id)}.to raise_error(ActionController::RoutingError)
  end

end
