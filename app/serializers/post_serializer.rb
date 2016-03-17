class PostSerializer < ActiveModel::Serializer
  attributes :id, :post_text

  # Relationships
  has_many :comments, as: :commentable, dependent: :destroy
end
