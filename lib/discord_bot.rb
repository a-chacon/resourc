require 'discordrb'

module DiscordBot
  BOT_TOKEN = Rails.application.credentials.dig(:discord, :token)

  @bot = Discordrb::Bot.new token: BOT_TOKEN

  @bot.server_create do |event|
    server = event.server

    # Create a new text channel
    response = server.create_channel('2048', 0)
    p response
  end

  @bot.message(with_text: 'Ping!') do |event|
    p event
    event.respond 'Pong!'
  end

  def self.send_message_link(_link)
    server_ids = @bot.servers.map { |server| server.id }
    p server_ids
  end

  def self.run
    @bot.run
  end
end
