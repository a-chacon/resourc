class CreateListDiscordChannels < ActiveRecord::Migration[7.0]
  def change
    create_table :list_discord_channels do |t|
      t.belongs_to :list, null: false, foreign_key: true
      t.belongs_to :discord_channel, null: false, foreign_key: true

      t.timestamps
    end

    add_index :list_discord_channels, %i[list_id discord_channel_id], unique: true
  end
end
