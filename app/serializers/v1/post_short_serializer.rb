class V1::PostShortSerializer < ActiveModel::Serializer
  attributes :id, :content, :likes_count, :created_at
end
