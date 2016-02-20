class SubComment < ActiveRecord::Base
  # Relationships
  belongs_to :user
  belongs_to :post_comment

  # Validations
  validates :comment_text, presence: true, length: { maximum: 140 }
  validates_presence_of :user_id
end
