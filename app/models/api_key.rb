class ApiKey < ActiveRecord::Base
  # Constants
  API_KEY_LIFETIME = 30.days

  # Associations
  belongs_to :user

  # Creating a token
  before_create :generate_token

  # Api key expiring
  before_create :set_expiration_date

  private

  def generate_token
    begin
      self.token = SecureRandom.hex.to_s
    end while self.class.exists?(token: token)
  end

  def set_expiration_date
    self.expires_at = self.updated_at + API_KEY_LIFETIME
  end
end
