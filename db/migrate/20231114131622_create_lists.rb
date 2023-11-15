class CreateLists < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|
      t.string :title
      t.string :slug, unique: true
      t.text :description
      t.boolean :public, default: true

      t.timestamps
    end
  end
end
