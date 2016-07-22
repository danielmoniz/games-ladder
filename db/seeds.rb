# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'ffaker'

categories = ["2015 Champions' League", "2016 World Tournament"]
categories.each do |category|
  Category.create(
    name: category,
    status: 'active',
  )
end

games = ['Ping Pong', 'Foosball']
games.map do |game|
  Game.create(name: game)
end

n = 50

n.times do |i|
  Player.create(
    email: FFaker::Internet.safe_email,
    name: FFaker::NameMX.name,
    favourite_game: games.sample,
  )
end

n.times do |i|
  team = Team.create(
    players: Player.all.sample(2),
  )
  player_names = team.players.map { |player| player.name }
  team.name = player_names.join(' y ')
  team.save
end

n.times do |i|
  match = Match.create(
    game: Game.all.sample,
    category: Category.all.sample,
  )
  match.teams.concat Team.all.sample(2)

  result = MatchResult.create(
    match: match,
    winner: match.teams.sample,
  )
end
