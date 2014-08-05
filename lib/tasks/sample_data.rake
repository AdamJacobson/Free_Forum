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

    25.times do |n|
      title = "#{Faker::Lorem.word.upcase}"
      description = "#{Faker::Lorem.words.join(" ")}"
      Board.create!(title: title,
                    description: description)
    end

    300.times do |n|
      title = "#{Faker::Lorem.words.join(" ")}"
      user_id = rand(1..100)
      board_id = rand(1..25)
      Topic.create!(title: title,
                    user_id: user_id,
                    board_id:board_id)
    end

  end
end