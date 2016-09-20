require 'rails_helper'

feature 'user signs out' , %Q{
  As an authenticated user
  I want to sign out
  So that no one else can post items or reviews on my behalf
} do

  # ACCEPTANCE CRITERIA
  # * If I am signed in, I must be able to sign out.
  # * If I am not signed in, I should not have the option
  #   to sign out.

  scenario 'signed in' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    click_link 'Sign Out'
    expect(page).to have_content('Signed out successfully.')
    expect(page).to have_content('Sign In')
    expect(page).to have_content('Sign Up')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'not signed in' do
    visit root_path
    expect(page).to have_content('Sign In')
    expect(page).to have_content('Sign Up')
    expect(page).to_not have_content('Sign Out')
  end

end
