class UserLink < ApplicationRecord
  belongs_to :user
  belongs_to :link

  enum :relationship_type, %i[owner like dislike]
end
