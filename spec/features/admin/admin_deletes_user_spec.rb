require 'rails_helper'
require 'pry'

feature 'admin deletes user', %Q{
  As an admin
  I want to delete a user
  So that I can protect my app
} do

  # * If I am an admin, I should be able to delete a user from the
  #   users index page.
  # * If I am not an admin, I should not be able to delete a user.

  scenario 'admin deletes a user' do
    user = FactoryGirl.create(:user, role: 'admin')
    user_2 = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link "View Users"

    click_button "Delete User"
    expect(page).to_not have_content(user_2.first_name)
    expect(page).to_not have_content(user_2.last_name)
    expect(page).to_not have_content(user_2.email)
  end

end
