class V2::PostShortSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :content, :likes_count, :tags, :created_at
end
