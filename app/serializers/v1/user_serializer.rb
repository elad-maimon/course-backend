class V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :created_at

  has_many :posts, serializer: V1::PostShortSerializer
  has_many :following, serializer: V1::UserShortSerializer
  has_many :followers, serializer: V1::UserShortSerializer
end
