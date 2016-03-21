class ApiKey < ActiveRecord::Base
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
    self.expiration = Date.today + 30.days
  end
end
