require 'rails_helper'
Capybara.default_driver = :selenium

feature 'user edits account' , %Q{
  As an authenticated user
  I want to delete my account
  So that my information is no longer retained by the app
} do

  # ACCEPTANCE CRITERIA
  # * If I am signed in, I should be able to delete my account.
  # * If I am not signed in, I should not be able to delete my account.

  scenario 'signed in' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'First Name', with: 'Matt'
    fill_in 'Last Name', with: 'Ryan'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    click_link 'Edit Profile'
    click_button 'Cancel my account'
    page.accept_alert

    click_link 'Sign In'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Sign In'
    expect(page).to have_content('Invalid Email or password.')
    expect(page).to_not have_content('Welcome Back!')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'not signed in' do
    visit root_path
    expect(page).to_not have_content("Edit Profile")
  end
end
