require 'rails_helper'

feature 'user views reviews', %Q{
  As a user
  I want to view a list of reviews for each team
  So that I can evaluate the team
} do

  # * I should be able to view a list of reviews on each teams detail page.
  # * I should see the team information and reviews on a team's detail page.

  scenario 'user view list of reviews' do
    user = FactoryGirl.create(:user)
    team = FactoryGirl.create(:team, user_id: user.id)
    review_1 = FactoryGirl.create(:review, user_id: user.id, team_id: team.id)
    review_2 = FactoryGirl.create(:review, user_id: user.id, team_id: team.id)
    review_3 = FactoryGirl.create(:review, user_id: user.id, team_id: team.id)
    visit root_path
    click_link "#{team.location} #{team.name} (#{team.league})"

    expect(page).to have_content(review_1.body)
    expect(page).to have_content(review_2.body)
    expect(page).to have_content(review_3.body)
  end

end
