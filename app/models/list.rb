class List < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: %i[slugged finders]

  has_many :user_lists, dependent: :destroy
  has_many :users, through: :user_lists

  has_many :link_lists, dependent: :destroy
  has_many :links, through: :link_lists

  has_many :list_discord_channel, dependent: :destroy
  has_many :discord_channels, through: :list_discord_channel
end
