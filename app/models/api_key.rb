class ApiKey < ActiveRecord::Base
  # Associations
  belongs_to :user

  # Creating a token
  before_create :generate_token

  private

  def generate_token
    begin
      self.token = SecureRandom.hex.to_s
    end while self.class.exists?(token: token)
  end
end
