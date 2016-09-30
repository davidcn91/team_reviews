require 'rails_helper'
require 'pry'

feature 'user searches for review', %Q{
  As a user
  I want to search for a review
  So that I can find a specific review
} do

  # * If I am on a Team show page, I should be able to search the
  #   reviews list for that team.
  # * If I search for a substring of a review that exists for the
  #   team whose page I am on, I should be shown that review.
  # * If I search for a review that exists for the
  #   team whose page I am not on, I should not be shown that review.

  scenario 'user searches for review that exists for given team' do
    user = FactoryGirl.create(:user)
    team = FactoryGirl.create(:team, user_id: user.id)
    review = FactoryGirl.create(:review, user_id: user.id, team_id: team.id)

    visit root_path
    click_link "#{team.location} #{team.name} (#{team.league})"

    fill_in 'Search Reviews', with: review.body
    click_button 'Search'

    expect(page).to have_content(review.body)
    expect(page).to have_content(review.rating)

    fill_in 'Search Reviews', with: review.body[2..(review.body.length-2)]
    click_button 'Search'
    expect(page).to have_content(review.body)
    expect(page).to have_content(review.rating)
  end

  scenario 'user searches for review that exists for a different team' do
    user = FactoryGirl.create(:user)
    team = FactoryGirl.create(:team, user_id: user.id)
    team_2 = FactoryGirl.create(:team, user_id: user.id)
    review = FactoryGirl.create(:review, user_id: user.id, team_id: team_2.id)

    visit root_path
    click_link "#{team.location} #{team.name} (#{team.league})"

    fill_in 'Search Reviews', with: review.body
    click_button 'Search'

    expect(page).to_not have_content(review.body)
    expect(page).to_not have_content(review.rating)
  end

  scenario 'user searches for review that does not exist' do
    user = FactoryGirl.create(:user)
    team = FactoryGirl.create(:team, user_id: user.id)
    review = FactoryGirl.create(:review, user_id: user.id, team_id: team.id)

    visit root_path
    click_link "#{team.location} #{team.name} (#{team.league})"

    fill_in 'Search Reviews', with: "Review that doesn't exist"
    click_button 'Search'

    expect(page).to_not have_content(review.body)
    expect(page).to_not have_content(review.rating)
  end

end
