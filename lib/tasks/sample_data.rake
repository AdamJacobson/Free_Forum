namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(username: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)

    99.times do |n|
      name  = "#{Faker::Name.first_name} #{rand(0..100)}"
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(username: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    5.times do |n|
      title = "Topic ##{n}"
      user_id = 1
      board_id = 1
      Topic.create!(title: title,
                    user_id: user_id,
                    board_id:board_id)
    end

    5.times do |n|
      title = "Board ##{n}"
      description = "description"
      Board.create!(title: title,
                    description: description)
    end
  end
end