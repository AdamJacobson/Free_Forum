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
      name  = "#{Faker::Name.first_name}#{rand(0..999)}"
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
    50.times do |n|
      topic_id = 1
      user_id = rand(1..100)
      Post.create!(content: fake_post,
       topic_id: topic_id,
       user_id: user_id)
      topic = Topic.find(1)
      topic.board_id = 1
      topic.save
    end



    # Initiate User
    20.times do |n|
      topic_id = rand(1..300)
      user_id = 2
      Post.create!(content: fake_post,
       topic_id: topic_id,
       user_id: user_id)
    end

    # Journeyman User
    50.times do |n|
      topic_id = rand(1..300)
      user_id = 3
      Post.create!(content: fake_post,
       topic_id: topic_id,
       user_id: user_id)
    end

    # Expert User
    100.times do |n|
      topic_id = rand(1..300)
      user_id = 4
      Post.create!(content: fake_post,
       topic_id: topic_id,
       user_id: user_id)
    end

    # Master User
    300.times do |n|
      topic_id = rand(1..300)
      user_id = 5
      Post.create!(content: fake_post,
       topic_id: topic_id,
       user_id: user_id)
    end

    # Posts
    1000.times do |n|
      topic_id = rand(1..300)
      user_id = rand(6..100)
      Post.create!(content: fake_post,
       topic_id: topic_id,
       user_id: user_id)
    end

    # Ranks
    Rank.create!(title: "Newbie", color: "#000000", requirement: 0)
    Rank.create!(title: "Initiate", color: "#008000", requirement: 10)
    Rank.create!(title: "Journeyman", color: "#0000FF", requirement: 15)
    Rank.create!(title: "Expert", color: "#FFA500", requirement: 20)
    Rank.create!(title: "Master", color: "#800080", requirement: 25)

    ModeratorJoin.create!(user_id: 2, board_id: 1)
  end
end