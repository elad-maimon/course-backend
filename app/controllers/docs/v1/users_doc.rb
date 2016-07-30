class Docs::V1::UsersDoc < Docs::V1::Base
  resource_description do
    resource_id 'Users'
  end

  api :GET, '/users', 'List users'
  def index; end

  api :GET, '/users/:id', 'Show user'
  param :id, :number, required: true
  def show; end

  api :POST, '/users', 'Sign up a new user (does not require authentication)'
  param :name, String, required: true
  param :email, String, required: true, desc: 'Must be a valid email address'
  param :password, Integer, required: true, desc: 'Must be minimum 6 characters'
  def create; end

  api :POST, '/users/:id/follow', 'Follow a user (applied to logged in user)'
  param :id, :number, required: true, desc: 'The user id to follow'
  def follow; end

  api :POST, '/users/:id/unfollow', 'Unfollow a user (applied to logged in user)'
  param :id, :number, required: true, desc: 'The user id to unfollow'
  def unfollow; end
end
