require 'rails_helper'
require 'pry'

feature 'user updates team', %Q{
  As an authenticated user
  I want to update an item's information
  So that I can correct errors or provide new information
} do

  # * If I am the creator of a team, I should be able to update the Team.
  # * If I specify valid Team information, the Team should be updated.
  # * If I do not specify valid Team information, the Team should not be updated
  #   and I should be provided an error message.
  # * If I am not the creator of the team, I should not be able to update the Team.

  before(:each) do
    @user = FactoryGirl.create(:user)
    @team = FactoryGirl.create(:team, user_id: @user.id)
  end

  scenario 'creator supplies valid information' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    click_link "#{@team.location} #{@team.name} (#{@team.league})"

    click_link "Edit Team"
    fill_in 'Location', with: 'Seattle'
    fill_in 'Name', with: 'Seahawks'
    select 'NFL', from: 'League'
    click_button 'Submit Team'

    expect(page).to have_content("Team updated successfully!")
    expect(page).to have_content("Seattle Seahawks (NFL)")
    expect(page).to have_content("Edit Team")
    expect(page).to have_content("Reviews")
  end

  scenario 'creator supplies invalid information' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    click_link "#{@team.location} #{@team.name} (#{@team.league})"

    click_link "Edit Team"
    fill_in 'Location', with: 'Seattle'
    fill_in 'Name', with: ''
    select 'NFL', from: 'League'
    click_button 'Submit Team'

    expect(page).to have_content("Please fill out all fields.")
    expect(page).to_not have_content("Reviews")
  end

  scenario 'user is not signed in' do
    visit root_path
    click_link "#{@team.location} #{@team.name} (#{@team.league})"

    expect(page).to_not have_content("Edit Team")

    visit edit_team_path(@team.id)
    fill_in 'Location', with: 'Seattle'
    fill_in 'Name', with: 'Seahawks'
    select 'NFL', from: 'League'
    click_button 'Submit Team'

    expect(page).to have_content("You must be signed in to update a team.")
    expect(page).to_not have_content("Reviews")
  end

  scenario 'authenticated user is not the creator of the team' do
    user_2 = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user_2.email
    fill_in 'Password', with: user_2.password
    click_button 'Sign In'
    click_link "#{@team.location} #{@team.name} (#{@team.league})"

    expect(page).to_not have_content("Edit Team")

    visit edit_team_path(@team.id)
    fill_in 'Location', with: 'Seattle'
    fill_in 'Name', with: 'Seahawks'
    select 'NFL', from: 'League'
    click_button 'Submit Team'

    expect(page).to have_content("You must be the creator of a team to update it.")
    expect(page).to_not have_content("Reviews")
  end

end
