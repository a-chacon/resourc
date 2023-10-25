class CreateLinksTags < ActiveRecord::Migration[7.0]
  def change
    create_table :links_tags do |t|
      t.belongs_to :link
      t.belongs_to :tag

      t.timestamps
    end
  end
end
