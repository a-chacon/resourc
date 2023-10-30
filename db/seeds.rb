# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'json'

def self.get_openai_data(title: '', description: '', url: '')
  object = { title:, description:, url: }
  client = OpenAI::Client.new(access_token: Rails.application.credentials.dig(:openai, :api_key),
                              organization_id: 'org-YeF1PAndkOGQdOpe38OlpQgo', request_timeout: 30)
  response = client.chat(
    parameters: {
      model: 'gpt-3.5-turbo',
      messages: [
        { role: 'user',
          content: "Given an object in JSON format, please identify the kind of resource it could be from the following options: [article, video, podcast, course, tool, ebook, documentation, presentation, template, community, event, talk, library, tutorial, newsletter, other] USE ONLY A VALID KIND. Generate up to three tags for the resource, it must be relevant for developers/tech people and if it is possible identify for which profile the resource is usefull (example: backend, frontend, devops, ux/ui, marketing, software architect,data scientist and more), one downcase word if it is possible. The response should be in JSON format and follow the structure: {kind: 'identified kind', tags: ['tag1', 'tag2', 'tag3']}. The object is #{object.to_json}" }
      ],
      temperature: 0.5
    }
  )
  p response
  JSON.parse(response.dig('choices', 0, 'message', 'content'))
end

bot = User.find_or_initialize_by(email: 'bot@2048.dev')
bot.name = '2048Bot'
bot.nickname = '2048_bot'
bot.save

file = File.read('db/resources2.json')
data = JSON.parse(file)

p 'Total resources: ' + data['data'].length.to_s

data['data'].each do |s|
  p s['name']
  next if Link.exists? link: s['url']

  link = Link.find_or_initialize_by(link: s['url'])
  link.title = s['name']
  link.description = s['description']
  begin
    kind_and_tags = get_openai_data(title: link.title, description: link.description, url: link.link)
    p 'JSON response:  ' + kind_and_tags.to_s
  rescue StandardError => e
    p "Error #{e}. Retry..."
    retry
  end
  link.kind = Link.kinds.keys.include?(kind_and_tags['kind']) ? kind_and_tags['kind'] : 'other'
  kind_and_tags['tags'].each { |t| link.tags << Tag.find_or_create_by(name: t) }
  link.user = bot
  link.skip_send_to_discord = true
  link.save!
rescue StandardError => e
  p 'Error ' + e.to_s
  break
end
