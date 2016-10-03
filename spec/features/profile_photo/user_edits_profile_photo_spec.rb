require "rails_helper"

feature "profile photo" do
  scenario "user edits a profile photo" do
    visit root_path
    click_link "Sign Up"

    fill_in "First Name", with: "David"
    fill_in "Last Name", with: "Nelson"
    fill_in "Email", with: "ash@s-mart.com"
    fill_in "Password", with: "boomstick!3vilisd3ad"
    fill_in "Password Confirmation", with: "boomstick!3vilisd3ad"
    attach_file "profile_photo", "#{Rails.root}/spec/support/images/mtwash.jpg"
    click_button "Sign Up"

    click_link "Edit Profile"
    fill_in "Current Password", with: "boomstick!3vilisd3ad"
    attach_file "profile_photo", "#{Rails.root}/spec/support/images/LI.jpg"
    click_button "Update"

    expect(page).to have_content("Your account has been updated successfully")
    expect(page).to have_css("img[src*='LI.jpg']")
  end
end
