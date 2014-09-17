# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Rank.create!(title: "Admin", color: "#FF0000", requirement: 0, system: true)
Rank.create!(title: "Moderator", color: "#00FFFF", requirement: 0, system: true)

Rank.create!(title: "Newbie", color: "#000000", requirement: 0)
Rank.create!(title: "Initiate", color: "#008000", requirement: 10)
Rank.create!(title: "Journeyman", color: "#0000FF", requirement: 15)
Rank.create!(title: "Expert", color: "#FFA500", requirement: 20)
Rank.create!(title: "Master", color: "#800080", requirement: 25)