class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :tagged_users, dependent: :destroy
  has_many :users, through: :tagged_users

  has_many_attached :media

  validates :media, size: { less_than: 200.megabytes , message: 'is too large' }

  before_save :shortend_content_urls, if: :body

  def shortend_content_urls
    require 'uri'
    urls = URI.extract(self.body, ['http', 'https'])
    slug_length = 6
    urls.each do |url|
      slug = rand(36**slug_length).to_s(36)
      link = ShortendedUrl.create(url: url, slug: slug)
      self.body = self.body.gsub!(url, link.short)
    end
  end

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

  def tagged_user_ids=(ids)
    self.user_ids = ids
  end
end
