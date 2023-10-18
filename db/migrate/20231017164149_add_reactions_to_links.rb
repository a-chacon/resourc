class AddReactionsToLinks < ActiveRecord::Migration[7.0]
  def change
    add_column :links, :reaction_like, :integer, default: 0, after: 'description'
    add_column :links, :reaction_love, :integer, default: 0, after: 'reaction_like'
    add_column :links, :reaction_haha, :integer, default: 0, after: 'reaction_love'
    add_column :links, :reaction_wow, :integer, default: 0, after: 'reaction_haha'
    add_column :links, :reaction_sad, :integer, default: 0, after: 'reaction_wow'
    add_column :links, :reaction_angry, :integer, default: 0, after: 'reaction_sad'
  end
end
