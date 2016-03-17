class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar, :email

  # Relationships
  has_many :posts, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
end
