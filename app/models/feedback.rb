class Feedback < ApplicationRecord
  validates :comment, presence: true
end
