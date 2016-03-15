class Post < ActiveRecord::Base
  # Relationships
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  # Validations
  validates :post_text, presence: true, length: { maximum: 140 }
  validates_presence_of :user_id

  # Default order
  default_scope -> { order('created_at DESC') }
end
