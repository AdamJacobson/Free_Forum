namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(username: "Example User",
     email: "example@railstutorial.org",
     password: "foobar",
     password_confirmation: "foobar",
     admin: true)

    # Create Users
    99.times do |n|
      name  = "#{Faker::Name.first_name} #{rand(0..100)}"
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(username: name,
       email: email,
       password: password,
       password_confirmation: password)
    end

    # Create Boards
    25.times do |n|
      title = "#{Faker::Lorem.word.upcase}"
      description = "#{Faker::Lorem.words.join(" ")}"
      Board.create!(title: title,
        description: description)
    end

    # Create Topics
    300.times do |n|
      title = "#{Faker::Lorem.words.join(" ")}"
      user_id = rand(1..100)
      board_id = rand(1..25)
      @topic = Topic.create!(title: title,
        user_id: user_id,
        board_id:board_id)
      @topic.posts.build(user_id: user_id,
                         content: "#{Faker::Lorem.paragraph(2)}")
      @topic.save
    end

    # Busy topic
    50.times do |n|
      content = "#{Faker::Lorem.paragraph(2)}"
      topic_id = 1
      user_id = rand(1..100)
      Post.create!(content: content,
       topic_id: topic_id,
       user_id: user_id)
    end

    1000.times do |n|
      content = "#{Faker::Lorem.paragraph(2)}"
      topic_id = rand(2..300)
      user_id = rand(1..100)
      Post.create!(content: content,
       topic_id: topic_id,
       user_id: user_id)
    end

  end
end