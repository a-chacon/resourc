class Link < ApplicationRecord
  has_many :user_links
  has_many :users, through: :user_links

  has_many :link_lists
  has_many :lists, through: :link_lists

  has_and_belongs_to_many :tags

  has_one_attached :thumbnail

  validates :title, presence: true
  validates :link, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validates :link, uniqueness: true

  scope :oldest_10, -> { order(updated_at: :asc).limit(10) }

  enum :kind,
       %w[article video podcast course tool ebook documentation presentation template community event talk library
          tutorial newsletter other]

  enum :status,
       %w[review active need_review enqueue_to_delete]

  def owner
    user_links.find { |ul| ul.relationship_type == 'owner' }.try(:user)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[description id kind link reaction_dislike reaction_like title
       user_id created_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[tags user]
  end
end
