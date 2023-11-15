# lib/discord/ping_command.rb

module Discord
  class SubscriptionsCommand
    extend Discordrb::Commands::CommandContainer
    command(:subscriptions, description: 'Subscribe the current channel to a Resourc List.') do |event, _list|
      discord_channel = DiscordChannel.find_by(server_id: event.server.id, channel_id: event.channel.id)

      if discord_channel.nil? || discord_channel.lists.empty?
        event.respond('No subscriptions yet.')
      else
        discord_channel.lists.pluck(:slug).join(', ')
      end
    end
  end
end
