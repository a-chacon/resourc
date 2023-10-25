class ChangeReactions < ActiveRecord::Migration[7.0]
  def change
    remove_column :links, :reaction_love, :integer, default: 0, after: 'reaction_like'
    remove_column :links, :reaction_haha, :integer, default: 0, after: 'reaction_love'
    remove_column :links, :reaction_wow, :integer, default: 0, after: 'reaction_haha'
    remove_column :links, :reaction_sad, :integer, default: 0, after: 'reaction_wow'
    remove_column :links, :reaction_angry, :integer, default: 0, after: 'reaction_sad'
    add_column :links, :reaction_dislike, :integer, default: 0, after: 'reaction_like'
  end
end
