require 'rails_helper'

feature 'user creates review', %Q{
  As an authenticated user
  I want to add a review for a team
  So that others can view it on the team page
} do

  # * If I am logged in, I should be able to add a review for a team.
  # * If I specify valid review information, the review should be added to the team page.
  # * If I do not specify a rating, I should not receive an error
  #   and my review should still be submitted without a rating.
  # * If I am not logged in, I should not be able to add a review
  #   and should receive an message indicating that I need to sign in.
  # * If I do not specify valid review information, the review should not be added
  #   and I should be provided an error message specifying the issue.

  before(:each) do
    @user = FactoryGirl.create(:user)
    @team = FactoryGirl.create(:team, user_id: @user.id)
    @body = "This team is awesome.  They play in the Georgia Dome in Atlanta."
  end

  scenario 'authenticated user supplies valid information' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    click_link "#{@team.location} #{@team.name} (#{@team.league})"

    click_link 'Add Review'
    fill_in 'Body', with: @body
    select 8, from: 'Rate Team (1-10)'
    click_button 'Submit Review'

    expect(page).to have_content("Review added successfully!")
    expect(page).to have_content(@body)
    expect(page).to have_content('8')
    expect(page).to have_content("Add Review")
  end

  scenario 'authenticated user supplies review body but does not provide rating' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    click_link "#{@team.location} #{@team.name} (#{@team.league})"

    click_link 'Add Review'
    fill_in 'Body', with: @body
    click_button 'Submit Review'

    expect(page).to have_content("Review added successfully!")
    expect(page).to have_content(@body)
    expect(page).to_not have_content('Team Rating')
    expect(page).to have_content("Add Review")
  end

  scenario 'user is not signed in' do
    visit root_path
    click_link "#{@team.location} #{@team.name} (#{@team.league})"
    expect(page).to_not have_content("Add Review")

    visit new_team_review_path(@team.id)
    fill_in 'Body', with: @body
    select 8, from: 'Rate Team (1-10)'
    click_button 'Submit Review'
    expect(page).to have_content("You must be signed in to add a review.")
    expect(page).to_not have_content("Add Review")
  end

  scenario 'authenticated user supplies invalid information' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    click_link "#{@team.location} #{@team.name} (#{@team.league})"

    click_link 'Add Review'
    fill_in 'Body', with: 'Too short of a review'
    click_button 'Submit Review'

    expect(page).to have_content("Review length must be 30 characters or greater.")
    expect(page).to_not have_content(@body)
    expect(page).to have_button("Submit Review")
  end

end
