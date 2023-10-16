class Link < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :link, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  after_create :send_to_discord

  def send_to_discord
    bot = Discordrb::Bot.new token: Rails.application.credentials.dig(:discord, :token)

    bot.ready do |event|
      puts "Logged in as #{event.bot.profile.username}"

      bot.servers.each do |server|
        channel = server[1].channels.find { |c| c.name == '2048' }

        if channel.nil?
          Rails.logger.warn "Server #{server} don't have the 2048 channel. Try to create."
          channel = server[1].create_channel('2048', 0)

          channel.send("**¡Bienvenido a 2048 Dev!** :tada:

Gracias por unirte a nosotros. Estamos emocionados de tenerte aquí. :computer:

**¿Qué puedes hacer aquí?**
- Compartir tus ideas y proyectos.
- Colaborar con otros desarrolladores.
- Aprender nuevas tecnologías y trucos.
- Mantente al tanto de las últimas noticias del mundo de la programación.

Si tienes alguna pregunta o necesitas ayuda, no dudes en preguntar en el canal correspondiente. ¡Esperamos que disfrutes de tu tiempo en el servidor y contribuyas al crecimiento de nuestra comunidad.

¡Feliz codificación! :rocket:
")
        end

        channel.send("## #{title}
#{description}

Compartido por: #{user.nickname}

#{link}
                     ")
      end
      bot.stop
    end
    bot.run
  rescue Exception => e
    Rails.logger.error e.to_s
  end
end
