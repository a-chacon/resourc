class AddStatusToLink < ActiveRecord::Migration[7.0]
  def change
    add_column :links, :status, :integer, default: 0
  end
end
