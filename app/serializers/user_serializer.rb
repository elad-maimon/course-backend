class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :created_at

  has_many :posts
  has_many :following, serializer: ShortUserSerializer
  has_many :followers, serializer: ShortUserSerializer
end
