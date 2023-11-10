class AddBlurhashToLink < ActiveRecord::Migration[7.0]
  def change
    add_column :links, :blurhash, :string, after: 'link'
  end
end
