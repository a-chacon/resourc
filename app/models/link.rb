class Link < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags

  validates :title, presence: true
  validates :link, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validates :link, uniqueness: true

  enum :kind,
       %w[article video podcast course tool ebook documentation presentation template community event talk library
          tutorial newsletter other]

  attr_accessor :skip_send_to_discord

  after_create :send_to_discord, unless: :skip_send_to_discord

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

  def self.ransackable_attributes(_auth_object = nil)
    %w[description id kind link reaction_dislike reaction_like title
       user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[tags user]
  end
end
