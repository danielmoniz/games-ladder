# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'ffaker'

categories = ["Champions' League", "World Tournament"]
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
  password = FFaker::Internet.password
  Player.create(
    email: FFaker::Internet.safe_email,
    password: password,
    password_confirmation: password,
    name: FFaker::NameMX.name,
    favourite_game: Game.all.sample,
    favourite_category: Category.all.sample,
  )
end

puts '--- 2-person teams/matches'
duo_teams = []

n.times do |i|
  team = Team.create(
    players: Player.all.sample(2),
  )
  player_names = team.players.map { |player| player.name }
  team.name = player_names.join(' y ')
  team.save
  duo_teams << team
end

n.times do |i|
  match = Match.create(
    game: Game.all.sample,
    category: Category.all.sample,
  )
  match.teams.concat duo_teams.sample(2)

  result = MatchResult.create(
    match: match,
    winner: match.teams.sample,
  )
end

puts Team.take
puts Player.take
puts Match.take

puts '---single person teams/matches'
single_teams = []

n.times do |i|
  team = Team.create(
    players: [Player.all.sample],
  )
  player_names = team.players.map { |player| player.name }
  team.name = player_names.join(' y ')
  team.save
  single_teams << team
end

puts '*'*20

n.times do |i|
  match = Match.create(
    game: Game.all.sample,
    category: Category.all.sample,
  )
  match.teams.concat single_teams.sample(2)

  result = MatchResult.create(
    match: match,
    winner: match.teams.sample,
  )
end
