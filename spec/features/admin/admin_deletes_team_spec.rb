require 'rails_helper'
require 'pry'

feature 'admin deletes team', %Q{
  As an admin
  I want to delete a team
  So that I can protect my app from bad data
} do

  # * If I am an admin, I should be able to delete a team from the
  #   teams index page.
  # * If I am not an admin, I should not be able to delete a team.

  scenario 'admin deletes a team' do
    user = FactoryGirl.create(:user, role: 'admin')
    user_2 = FactoryGirl.create(:user)
    team = FactoryGirl.create(:team, user_id: user_2.id)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link "#{team.location} #{team.name} (#{team.league})"

    click_button 'Delete Team'
    expect(page).to_not have_content(team.location)
    expect(page).to_not have_content(team.name)
    expect(page).to_not have_content(team.league)
  end

end
