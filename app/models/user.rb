class User < ApplicationRecord
  extend FriendlyId
  friendly_id :nickname, use: %i[slugged finders]

  has_one_attached :avatar
  has_many :user_links
  has_many :links, through: :user_links

  validates :email, uniqueness: true

  before_create :complete
  after_create :check_avatar

  def attach_external_avatar(url)
    require 'open-uri'

    downloaded_image = URI.open(url)
    avatar.attach(io: downloaded_image, filename: 'image.jpg', content_type: 'image/jpeg')
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[name nickname]
  end

  private

  def complete
    self.nickname = email.split('@')[0] if nickname.nil?
  end

  def check_avatar
    return if avatar.attached?

    attach_external_avatar('https://ucem.edu.ni/wp-content/uploads/2018/12/default-avatar-300x300.png')
  end
end
