require 'rails_helper'

feature 'user views teams', %Q{
  As a user
  I want to view a list of teams
  So that I can pick a team to review
} do

  # * I should be able to view a list of teams from the root index.
  # * I should be able to click on any team to view its details.
  # * I should see the team information and reviews on a team's detail page.

  scenario 'user view list of teams' do
    visit root_path
    expect(page).to have_content('Teams')
  end

  scenario 'user clicks on team link' do
    user = FactoryGirl.create(:user)
    team = FactoryGirl.create(:team, user_id: user.id)
    visit root_path
    click_link "#{team.location} #{team.name} (#{team.league})"

    expect(page).to have_content(team.location)
    expect(page).to have_content(team.name)
    expect(page).to have_content(team.league)
    expect(page).to have_content("Reviews")
  end

end
