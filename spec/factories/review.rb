FactoryGirl.define do
  factory :review do
    sequence(:body) { |n| "This team is awesome.  They play in the Georgia Dome in Atlanta.#{n}" }
    rating 8
  end
end
