require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(username: "Site Admin",
     email: "example@railstutorial.org",
     password: "password",
     password_confirmation: "password",
     admin: true)

    # Create Users
    99.times do |n|
      name  = "#{Faker::Name.first_name}#{rand(0..100)}"
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(username: name,
       email: email,
       password: password,
       password_confirmation: password)
    end

    # Create Boards
    15.times do |n|
      title = "#{Faker::Lorem.word.upcase}"
      description = "#{Faker::Lorem.words.join(" ")}"
      Board.create!(title: title,
       description: description)
    end

    # Create Topics
    300.times do |n|
      title = "#{Faker::Lorem.words.join(" ").capitalize!}"
      user_id = rand(1..100)
      board_id = rand(1..15)
      @topic = Topic.create!(title: title,
       user_id: user_id,
       board_id: board_id,
       sticky: (rand(10) == 0))
      @topic.posts.build(user_id: user_id,
       content: fake_post)
      @topic.save
    end

    # Posts for a busy topic in Board 1
    57.times do |n|
      content = fake_post
      topic_id = 1
      user_id = rand(1..100)
      Post.create!(content: content,
       topic_id: topic_id,
       user_id: user_id)
      topic = Topic.find(1)
      topic.board_id = 1
      topic.save
    end

    # Posts
    1000.times do |n|
      content = fake_post
      topic_id = rand(2..300)
      user_id = rand(1..100)
      Post.create!(content: content,
       topic_id: topic_id,
       user_id: user_id)
    end
  end
end