require 'rails_helper'
require 'pry'

feature 'user edits account' , %Q{
  As an authenticated user
  I want to update my information
  So that I can keep my profile up to date
} do

  # ACCEPTANCE CRITERIA
  # * If I am signed in, I should be able to navigate to an edit profile page
  # * I should be able to update my email, password, first name, and last name.
  # * If I am not signed in, i should not be able to access an edit profile page.

  scenario 'specifying valid and required information' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    click_link 'Edit Profile'
    fill_in 'First Name', with: 'Matt'
    fill_in 'Last Name', with: 'Ryan'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'user_password', with: 'newpassword'
    fill_in 'Password Confirmation', with: 'newpassword'
    fill_in 'Current Password', with: (user.password)
    click_button 'Update'

    click_link 'Edit Profile'
    expect(page).to have_selector("input[value='Matt']")
    expect(page).to have_selector("input[value='Ryan']")
    expect(page).to have_selector("input[value='user@example.com']")
    fill_in 'user_password', with: ''
    fill_in 'Password Confirmation', with: ''
    fill_in 'Current Password', with: ('newpassword')
    click_button 'Update'

    expect(page).to have_content('Home')
  end

  scenario 'required information is not supplied' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    click_link 'Edit Profile'
    fill_in 'First Name', with: 'Matt'
    fill_in 'Last Name', with: 'Ryan'
    fill_in 'Email', with: ''
    fill_in 'user_password', with: 'newpassword'
    fill_in 'Password Confirmation', with: 'newpassword'
    fill_in 'Current Password', with: (user.password)
    click_button 'Update'

    expect(page).to have_content("Email can't be blank")
  end

  scenario 'incorrect password provided' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    click_link 'Edit Profile'
    fill_in 'First Name', with: 'Matt'
    fill_in 'Last Name', with: 'Ryan'
    fill_in 'Email', with: 'davidcn@bu.edu'
    fill_in 'user_password', with: 'newpassword'
    fill_in 'Password Confirmation', with: 'newpassword'
    fill_in 'Current Password', with: 'wrongpassword'
    click_button 'Update'

    expect(page).to have_content("Current password is invalid")
  end

  scenario 'password confirmation does not match password' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    click_link 'Edit Profile'
    fill_in 'First Name', with: 'Matt'
    fill_in 'Last Name', with: 'Ryan'
    fill_in 'Email', with: 'davidcn@bu.edu'
    fill_in 'user_password', with: 'newpassword'
    fill_in 'Password Confirmation', with: 'wrongnewpassword'
    fill_in 'Current Password', with: user.password
    click_button 'Update'

    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
