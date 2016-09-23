require 'rails_helper'
require 'spec_helper'

RSpec.describe Review do
  it { should have_valid(:body).when('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 'bbraerbaebrabreerbaerbaerbarebaerberbaerbaerberabaerbaerb') }
  it { should_not have_valid(:body).when(nil, 'Too short', '') }

  it { should have_valid(:rating).when(8, 4, nil) }
  it { should_not have_valid(:rating).when(11, 'not a rating') }

  it { should have_valid(:user_id).when(1, 2) }
  it { should_not have_valid(:user_id).when(nil, 0, -1) }

  it { should have_valid(:team_id).when(3, 4) }
  it { should_not have_valid(:team_id).when(nil, 0, -2) }

end
