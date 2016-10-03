require 'rails_helper'
require 'pry'

feature 'user deletes team', %Q{
  As an authenticated user
  I want to delete an item
  So that no one can review it
} do

  # * If I am the creator of a team, I should be able to destroy the Team.
  # * If I destroy the team, it should destroy all of it's reviews.
  # * If I am not the creator of the team, I should not be able to destroy the Team.

  scenario 'signed in user is the creator of the team' do
    user = FactoryGirl.create(:user)
    team = FactoryGirl.create(:team, user_id: user.id)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link "#{team.location} #{team.name} (#{team.league})"

    click_button 'Delete Team'
    expect(page).to have_content("Professional Sports Team Reviews")
    expect(page).to_not have_content(team.location)
    expect(page).to_not have_content(team.name)
    expect(page).to_not have_content(team.league)
  end

  scenario 'user is not signed in' do
    user = FactoryGirl.create(:user)
    team = FactoryGirl.create(:team, user_id: user.id)
    visit root_path
    click_link "#{team.location} #{team.name} (#{team.league})"

    expect(page).to_not have_content("Delete Team")
  end

  scenario 'signed in user is not creator of the team' do
    user_1 = FactoryGirl.create(:user)
    user_2 = FactoryGirl.create(:user)
    team = FactoryGirl.create(:team, user_id: user_1.id)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user_2.email
    fill_in 'Password', with: user_2.password
    click_button 'Sign In'
    click_link "#{team.location} #{team.name} (#{team.league})"

    expect(page).to_not have_content("Delete Team")
  end


end
