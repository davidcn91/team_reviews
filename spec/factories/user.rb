FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "person#{n}@example.com" }
    sequence(:first_name) {|n| "John#{n}" }
    sequence(:last_name) {|n| "Smith#{n}" }
    password 'password'
    password_confirmation 'password'
  end
end
