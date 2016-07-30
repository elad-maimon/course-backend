class Post < ApplicationRecord
  has_many :like_relations
  has_many :likes, through: :like_relations, source: :user

  serialize :tags, Array

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 1000 }

  def like_by(user_id)
    like_relations.create user_id: user_id
  end

  def unlike_by(user_id)
    like_relations.find_by!(user_id: user_id).destroy
  end

  def likes_count
    likes.size
  end
end
