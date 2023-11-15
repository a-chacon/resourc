module LinkServices
  class ShareOnDiscordChannels
    def initialize(link: Link)
      @link = link
    end

    def run
      @link.lists.each do |l|
        l.discord_channels.each do |dc|
          Discordrb::API::Channel.create_message(
            'Bot ' + Rails.application.credentials.dig(:discord, :token),
            dc.channel_id,
            <<~EOS
              ## [#{@link.title}](#{@link.link})

              #{@link.description}

              By: #{@link.owner.nickname}

              **#{@link.tags.pluck(:name).join(' ,')}**

            EOS
          )
        end
      end
    end
  end
end
