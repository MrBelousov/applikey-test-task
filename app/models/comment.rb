class Comment < ActiveRecord::Base
  # Relationships
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy

  # Validations
  validates :text, presence: true, length: { maximum: 140 }
end
