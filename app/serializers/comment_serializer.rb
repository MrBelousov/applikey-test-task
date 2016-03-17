class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text

  # Relationships
  has_many :comments, as: :commentable, dependent: :destroy
end
