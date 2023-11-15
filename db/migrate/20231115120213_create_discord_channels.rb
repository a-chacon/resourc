class CreateDiscordChannels < ActiveRecord::Migration[7.0]
  def change
    create_table :discord_channels do |t|
      t.string :server_id
      t.string :channel_id

      t.timestamps
    end
  end
end
