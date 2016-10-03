require 'rails_helper'
require 'pry'

feature 'user receives email when team is reviewed', %Q{
  As a user who created a team
  I want to receive a welcome email when someone reviews it
  So that I can keep track of my reviews.
} do

  # * If I have created a team and someone reviews it, I should receive
  #   a notification email.
  # * If I did not create the team that was reviewed, I should not
  #   receive an email.

  scenario "user's team is reviewed" do
    ActionMailer::Base.deliveries.clear

    user = FactoryGirl.create(:user)
    user_2 = FactoryGirl.create(:user)
    team = FactoryGirl.create(:team, user_id: user.id)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user_2.email
    fill_in 'Password', with: user_2.password
    click_button 'Sign In'
    click_link "#{team.location} #{team.name} (#{team.league})"
    click_link 'Add Review'
    fill_in 'Body', with: "New Review New Review New Review New Review New Review New Review New Review New Review"
    select 8, from: 'Rate Team (1-10)'
    click_button 'Submit Review'

    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

end
