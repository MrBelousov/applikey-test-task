class User < ActiveRecord::Base
  # Relationships
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :api_keys, dependent: :destroy

  # Ensuring email uniqueness by downcasing the email attribute.
  before_save { self.email = email.downcase }
  # Creating remember token for each user
  before_create :create_remember_token

  # Creating an api key for user
  after_save :create_api_key

  # Validations
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 8 }

  # Pagination
  paginates_per 5

  # Authenticate methods
  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_api_key
    self.api_keys.create
  end

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
