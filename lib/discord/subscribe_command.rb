# lib/discord/ping_command.rb

module Discord
  class SubscribeCommand
    extend Discordrb::Commands::CommandContainer

    command(:subscribe, description: 'Subscribe the current channel to a Resourc List.') do |event, list_slug|
      list = List.find_by(slug: list_slug)
      discord_channel = DiscordChannel.find_or_create_by(server_id: event.server.id, channel_id: event.channel.id)
      if list.nil?
        'Please enter a valid list id'
      else
        discord_channel.lists << list
        discord_channel.save
        'Subscribed!'
      end
    end
  end
end
