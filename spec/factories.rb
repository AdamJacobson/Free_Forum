FactoryGirl.define do
  factory :user do
    username "example"
    email    "example@email.com"
    password "password"
    password_confirmation "password"
  end
end