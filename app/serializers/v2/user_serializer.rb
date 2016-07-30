class V2::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :created_at

  has_many :posts, serializer: V2::PostShortSerializer
end
