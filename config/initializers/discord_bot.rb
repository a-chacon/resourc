# require_relative '../../lib/discord_bot'
#
# DiscordBot.run
require 'discordrb'

bot = Discordrb::Commands::CommandBot.new token: Rails.application.credentials.dig(:discord, :token), prefix: '!'

# Dynamically load all command modules
Dir[File.join(File.dirname(__FILE__), '../../lib/discord/*.rb')].each do |file|
  require file
  command_module_name = File.basename(file, '.rb').camelize
  bot.include! Discord.const_get(command_module_name)
end

bot.message(content: 'Ping!') do |event|
  event.respond 'Pong!'
end

Thread.new { bot.run }
