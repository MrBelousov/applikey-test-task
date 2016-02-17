class Post < ActiveRecord::Base
  # Validations
  validates :post_text, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  # Default order
  default_scope -> { order('created_at DESC') }

  # Relationships
  belongs_to :user
  has_many :post_comments, dependent: :destroy
end
