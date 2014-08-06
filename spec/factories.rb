FactoryGirl.define do
  factory :user do
  	sequence(:username) { |n| "Person#{n}" }
  	sequence(:email)		{ |n| "person_#{n}@example.com" }
    password "password"
    password_confirmation "password"

    factory :admin do
      admin true
    end
  end

  factory :topic do
  	title "Test Topic"
  	board_id 1
  end

  factory :board do
    title "Test Board"
    description "Test description"
  end
end