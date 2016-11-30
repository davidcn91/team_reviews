require 'rails_helper'

feature 'new user receives welcome email', %Q{
  As a user who signs up
  I want to receive a welcome email
  So that I can comfirm I have signed up.
} do

  # * If I sign up, I should receive an email indicating I have joined.
  # * If I have already signed up, I should not receive a duplicate email.

  scenario "user signs up" do
    ActionMailer::Base.deliveries.clear

    visit root_path
    click_link 'Sign Up'
    fill_in 'First Name', with: 'Matt'
    fill_in 'Last Name', with: 'Ryan'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

end
