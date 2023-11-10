class UserLink < ApplicationRecord
  belongs_to :user
  belongs_to :link

  after_create_commit :add_link_count
  before_destroy :substract_link_count

  enum :relationship_type, %i[owner like dislike]

  private

  def add_link_count
    case relationship_type
    when 'like'
      link.update(reaction_like: link.reaction_like + 1)
    when 'dislike'
      link.update(reaction_dislike: link.reaction_dislike + 1)
    end
  end

  def substract_link_count
    case relationship_type
    when 'like'
      link.update(reaction_like: link.reaction_like - 1)
    when 'dislike'
      link.update(reaction_dislike: link.reaction_dislike - 1)
    end
  end
end
