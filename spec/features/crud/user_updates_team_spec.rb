require 'rails_helper'

feature 'user updates team', %Q{
  As an authenticated user
  I want to update an item's information
  So that I can correct errors or provide new information
} do

  # * If I am the creator of a team, I should be able to update the Team.
  # * If I specify valid Team information, the Team should be updated.
  # * If I do not specify valid Team information, the Team should not be updated
  #   and I should be provided an error message.
  # * If I am not the creator of the team, I should not be able to update the Team.


  scenario 'authenticated user supplies valid information' do

  end

  scenario 'user is not signed in' do

  end

  scenario 'authenticated user supplies invalid information' do

  end

end
