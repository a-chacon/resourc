class AddKindToLink < ActiveRecord::Migration[7.0]
  def change
    add_column :links, :kind, :integer, default: 0
  end
end
