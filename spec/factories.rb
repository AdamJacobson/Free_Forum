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
    title "Test Board"
    description "Test description"
  end

  factory :topic do
  	title "Test Topic"
  end

  factory :post do
    content "Content"
  end

end