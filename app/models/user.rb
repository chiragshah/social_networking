class User < ApplicationRecord
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users
  has_many :posts
  has_many :tagged_users
  has_many :tagged_posts, through: :tagged_users, class_name: 'Post'

  has_one_attached :image
  
  validates_presence_of :username, :email, :password
  validates :password, length: { minimum: 8 }
  validates :username, :email, uniqueness: true

  before_save :generate_auth_token
  before_save :hash_password

  private 

  def hash_password
    if self.password_changed?
      self.password = Digest::SHA256.hexdigest(self.password)
    end
  end

  def generate_auth_token
    if self.password_changed?
      self.auth_token = Digest::SHA2.hexdigest(self.email + self.password)
    end
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
