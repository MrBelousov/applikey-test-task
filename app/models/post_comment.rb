class PostComment < ActiveRecord::Base
  # Relationships
  belongs_to :user
  belongs_to :post
  has_many :sub_comments, dependent: :destroy

  # Validations
  validates :comment_text, presence: true, length: { maximum: 140 }
  validates_presence_of :user_id
end
