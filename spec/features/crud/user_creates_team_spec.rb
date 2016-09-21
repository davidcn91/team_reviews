require 'rails_helper'

feature 'user creates team', %Q{
  As an authenticated user
  I want to add an item
  So that others can review it
} do

  # * If I am logged in, I should be able to add a Team.
  # * If I specify valid Team information, the Team should be added.
  # * If I am not logged in, I should not be able to add a Team.
  # * If I do not specify valid Team information, the Team should not be added
  #   and I should be provided an error message specifying the issue.

  scenario 'authenticated user supplies valid information' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    click_link 'Add New Team'
    fill_in 'Location', with: 'Atlanta'
    fill_in 'Name', with: 'Falcons'
    select 'NFL', from: 'League'
    click_button 'Submit Team'

    expect(page).to have_content("Team added successfully!")
    expect(page).to have_content("Atlanta Falcons (NFL)")
    expect(page).to have_content("Add New Team")
  end

  scenario 'user is not signed in' do
    visit root_path
    expect(page).to_not have_content("Add New Team")

    visit new_team_path
    fill_in 'Location', with: 'Atlanta'
    fill_in 'Name', with: 'Falcons'
    select 'NFL', from: 'League'
    click_button 'Submit Team'
    expect(page).to have_content("You must be signed in to add a team.")
    expect(page).to_not have_content("Home")
  end

  scenario 'authenticated user supplies invalid information' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    click_link 'Add New Team'
    fill_in 'Location', with: 'Atlanta'
    select 'NFL', from: 'League'
    click_button 'Submit Team'
    expect(page).to have_content("Please fill out all fields.")
    expect(page).to_not have_content("Home")
  end

end
