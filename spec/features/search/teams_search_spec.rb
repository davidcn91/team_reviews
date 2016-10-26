require 'rails_helper'

feature 'user searches for team', %Q{
  As a user
  I want to search for a team
  So that I can find a specific team
} do

  # * If I am on the Teams home page, I should be able to search the
  #   teams list by team name.
  # * If I search for a substring of a team that exists, I should be
  #   shown that team.

  scenario 'user searches for team that exists' do
    user = FactoryGirl.create(:user)
    team = FactoryGirl.create(:team, user_id: user.id)
    visit root_path

    fill_in 'Search Teams', with: team.name
    click_button 'Search'
    expect(page).to have_content(team.location)
    expect(page).to have_content(team.name)
    expect(page).to have_content(team.league)

    fill_in 'Search Teams', with: team.name[2..(team.name.length-2)]
    click_button 'Search'
    expect(page).to have_content(team.location)
    expect(page).to have_content(team.name)
    expect(page).to have_content(team.league)
  end

  scenario 'user searches for team that does not exist' do
    user = FactoryGirl.create(:user)
    team = FactoryGirl.create(:team, user_id: user.id)
    visit root_path

    fill_in 'Search Teams', with: 'Thrashers'
    click_button 'Search'
    expect(page).to_not have_content(team.location)
    expect(page).to_not have_content(team.name)
    expect(page).to_not have_content(team.league)
  end

end
