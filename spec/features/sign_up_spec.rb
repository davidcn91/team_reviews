require 'spec_helper'
require 'rails_helper'

feature 'sign up' , %Q{
  As a prospective user
  I want to create an account
  So that I can post items and review them
} do

  # ACCEPTANCE CRITERIA
  # * I must specify a valid email address
  # * I must specify a password, and confirm that password
  # * If I do not perform the above, I get an error message
  # * If I specify valid information, I register my account and am authenticated

  scenario 'specifying valid and required information' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'First Name', with: 'Matt'
    fill_in 'Last Name', with: 'Ryan'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content("You're In!")
    expect(page).to have_content("Sign Out")
  end

  scenario 'required information is not supplied' do

  end

  scenario 'password confirmation does not match confirmation' do

  end
end
