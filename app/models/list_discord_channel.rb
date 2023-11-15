class ListDiscordChannel < ApplicationRecord
  belongs_to :list
  belongs_to :discord_channel
end
