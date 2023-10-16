class Link < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :link, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  # after_create :send_to_discord

  private

  def send_to_discord
    bot = Discordrb::Bot.new token: Rails.application.credentials.dig(:discord, :token)
    bot.send_message('1109574284789166201',
                     "Nuevo mensaje recibido de #{recipe_user.first_name} #{recipe_user.last_name} - #{recipe_user.phone_number}:``` #{message} ``` ")
  end
end
