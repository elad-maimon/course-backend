class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at

  has_many :likes, serializer: Class.new(ActiveModel::Serializer) {
    attributes :id, :name
  }
end
