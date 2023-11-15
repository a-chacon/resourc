class DiscordChannel < ApplicationRecord
  has_many :list_discord_channel, dependent: :destroy
  has_many :lists, through: :list_discord_channel
end
