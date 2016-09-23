require 'rails_helper'
require 'pry'

feature 'admin deletes review', %Q{
  As an admin
  I want to delete a review
  So that I can protect my app from bad data
} do

  # * If I am an admin, I should be able to delete a review from the
  #   reviews index page.
  # * If I am not an admin, I should not be able to delete a review.

  scenario 'admin deletes a user' do
    user = FactoryGirl.create(:user, role: 'admin')
    user_2 = FactoryGirl.create(:user)
    team = FactoryGirl.create(:team, user_id: user_2.id)
    review = FactoryGirl.create(:review, user_id: user_2.id, team_id: team.id)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link "#{team.location} #{team.name} (#{team.league})"

    click_button 'Delete Review'
    expect(page).to have_content("#{team.location} #{team.name} (#{team.league})")
    expect(page).to_not have_content(review.body)
    expect(page).to_not have_content(review.rating)
  end

end
