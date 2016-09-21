require 'rails_helper'
require 'spec_helper'

RSpec.describe Team do
  it { should have_valid(:location).when('Atlanta', 'Kansas City') }
  it { should_not have_valid(:location).when(nil, '') }

  it { should have_valid(:name).when('Falcons', 'Chiefs') }
  it { should_not have_valid(:name).when(nil, '') }

  it { should have_valid(:league).when('NFL', 'MLB') }
  it { should_not have_valid(:league).when(nil, '', 'XXX', 'jjjj') }

end
