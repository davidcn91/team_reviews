require 'rails_helper'

RSpec.describe Vote do
  it { should have_valid(:score).when(1, -1, 0) }
  it { should_not have_valid(:score).when(nil, 'not a score') }

  it { should have_valid(:user_id).when(1, 2) }
  it { should_not have_valid(:user_id).when(nil, 0, -1) }

  it { should have_valid(:review_id).when(3, 4) }
  it { should_not have_valid(:review_id).when(nil, 0, -2) }
end
