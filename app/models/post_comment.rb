class PostComment < ActiveRecord::Base
  # Validations
  validates :comment_text, presence: true, length: { maximum: 140 }
  validates_presence_of :user_id

  # Relationships
  belongs_to :user
  belongs_to :post
  # Comments to comments
  has_many :sub_comments, dependent: :destroy
end
