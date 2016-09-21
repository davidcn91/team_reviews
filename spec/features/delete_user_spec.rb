require 'rails_helper'
require 'pry'

feature 'user edits account' , %Q{
  As an authenticated user
  I want to delete my account
  So that my information is no longer retained by the app
} do

  # ACCEPTANCE CRITERIA
  # * If I am signed in, I should be able to delete my account.
  # * If I am not signed in, I should not be able to delete my account.

  scenario 'signed in' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    click_link 'Edit Profile'
    click_button 'Cancel my account'
    page.driver.accept_js_confirms
    expect(user).to_not be_a(:user)
  end

  scenario 'not signed in' do
    expect(page).to_not have_content("Edit Profile")
  end

end
