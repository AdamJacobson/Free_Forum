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

  factory :board do
    sequence(:title) { |n| "Board#{n}" }
    description "Description"
  end

  factory :topic do
    sequence(:title) { |n| "Topic#{n}" }
  end

  factory :post do
    content "Content"
  end

  factory :rank do
    sequence(:title) { |n| "Rank#{n}" }
    color "#000000"
    requirement 3
  end
end