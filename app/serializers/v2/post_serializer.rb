class V2::PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :likes_count, :tags, :created_at

  has_many :likes, serializer: Class.new(ActiveModel::Serializer) {
    attributes :id, :name
  }
end
