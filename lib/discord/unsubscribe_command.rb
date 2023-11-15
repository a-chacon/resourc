# lib/discord/ping_command.rb

module Discord
  class UnsubscribeCommand
    extend Discordrb::Commands::CommandContainer

    command(:unsubscribe, description: 'Subscribe the current channel to a Resourc List.') do |event, list|
      list_discord_channel = ListDiscordChannel.find_by(
        discord_channel_id: DiscordChannel.find_by(server_id: event.server.id,
                                                   channel_id: event.channel.id).id,
        list_id: List.find_by(slug: list).id
      )
      if list_discord_channel.nil?
        'List not found in this channel subscriptions'
      else
        list_discord_channel.destroy
        'Subscription removed'
      end
    rescue Exception => e
      Rails.logger.debug(e.to_s)
      'Something is not fine. Please enter a valid list id.'
    end
  end
end
