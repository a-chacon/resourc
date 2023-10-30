class Tag < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[slugged finders]

  has_and_belongs_to_many :links

  def self.ransackable_attributes(_auth_object = nil)
    ['name']
  end

  def self.ransackable_associations(_auth_object = nil)
    ['links']
  end
end
