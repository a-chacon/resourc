class User < ApplicationRecord
  has_one_attached :avatar

  has_many :links, dependent: :destroy

  validates :email, uniqueness: true

  before_create :complete
  after_create :check_avatar

  def attach_external_avatar(url)
    require 'open-uri'

    downloaded_image = URI.open(url)
    avatar.attach(io: downloaded_image, filename: 'image.jpg', content_type: 'image/jpeg')
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