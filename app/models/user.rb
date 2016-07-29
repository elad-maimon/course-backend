class User < ApplicationRecord
  has_secure_password
  attr_accessor :auth_token

  has_many :posts, dependent: :destroy
  has_many :active_relationships,  class_name:  'Relationship',
                                   foreign_key: 'follower_id',
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 250 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  before_save { email.downcase! }


  def follow(user_id)
    active_relationships.create followed_id: user_id
  end

  def unfollow(user_id)
    active_relationships.find_by!(followed_id: user_id).destroy
  end

  def following?(other_user)
    following.include? other_user
  end

  def generate_token
    self.auth_token = SecureRandom.urlsafe_base64
    update_attribute :token_digest, User.digest(auth_token)
  end

  def clear_token
    update_attribute :auth_token, nil
  end

  def authenticated?(auth_token)
    return false if token_digest.nil?
    BCrypt::Password.new(token_digest).is_password? auth_token
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
