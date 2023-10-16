class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.text :link
      t.string :title
      t.text :description
      t.belongs_to :user

      t.timestamps
    end
  end
end
