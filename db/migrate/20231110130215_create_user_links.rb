class CreateUserLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :user_links do |t|
      t.references :user
      t.references :link
      t.integer :relationship_type, default: 0 # Columna para el tipo de relación

      t.timestamps
    end

    # Añade un índice único para evitar duplicados
    add_index :user_links, %i[user_id link_id relationship_type], unique: true
  end
end
