require 'rails_helper'

feature 'user views teams', %Q{
  As an authenticated user
  I want to view a list of items
  So that I can pick items to review

  As an authenticated user
  I want to view the details about an item
  So that I can get more information about it
} do

  # * I should be able to view a list of teams from the root index.
  # * I should be able to click on any team to view its details.
  # * I should see the team information and reviews on a team's detail page.

  scenario 'user view list of teams' do
    visit root_path
    expect(page).to have_content('Teams')
  end

  scenario 'user clicks on team link' do
    team = FactoryGirl.create(:team)
    visit root_path
    click_link "#{team.location} #{team.name} (#{team.league})"

    expect(page).to have_content(team.location)
    expect(page).to have_content(team.name)
    expect(page).to have_content(team.league)
    expect(page).to have_content("Reviews")
  end

end
