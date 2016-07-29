class Post < ApplicationRecord
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 1000 }
end
