class CreateUserLists < ActiveRecord::Migration[7.0]
  def change
    create_table :user_lists do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :list, null: false, foreign_key: true
      t.integer :relationship_type, default: 0

      t.timestamps
    end
  end
end
