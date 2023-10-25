# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'json'

bot = User.find_or_initialize_by(email: 'bot@2048.dev')
bot.name = '2048Bot'
bot.nickname = '2048_bot'
bot.save

file = File.read('db/resources.json')
data = JSON.parse(file)

data['data'].each do |s|
  p s['name']
  link = Link.find_or_initialize_by(link: s['url'])
  link.title = s['name']
  link.description = s['description']
  s['categories'].each { |c| link.tags << Tag.find_or_create_by(name: c) } if s['categories']
  s['keywords'].each { |c| link.tags << Tag.find_or_create_by(name: c) } if s['keywords']
  link.user = bot
  link.skip_send_to_discord = true
  link.save!
end
