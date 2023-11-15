# lib/discord/ping_command.rb

module Discord
  class PingCommand
    extend Discordrb::Commands::CommandContainer

    command(:ping) do |event|
      event.respond 'Pong!'
    end
  end
end
