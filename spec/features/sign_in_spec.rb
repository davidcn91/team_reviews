require 'spec_helper'
require 'rails_helper'

feature 'user signs in', %Q{
  As an unauthenticated user
  I want to sign in
  So that I can post items and review them
} do

  # * If I specify a valid, previously registered email and password,
  #   I am authenticated and I gain access to the system
  # * If I specify an invalid email and password, I remain unauthenticated
  # * If I am already signed in, I can't sign in again

  scenario 'an existing user supplies a valid email and password' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password Confirmation', with: user.password_confirmation
    click_button 'Sign In'
    expect(page).to have_content('Welcome Back!')
    expect(page).to have_content('Sign Out')
  end


  scenario 'a nonexistent email and password is supplied' do

  end

  scenario 'an existing email with the wrong password is denied access' do

  end

  scenario 'an already authenticated user cannot re-sign in' do

  end
end
