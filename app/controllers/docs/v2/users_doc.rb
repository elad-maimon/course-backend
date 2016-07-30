class Docs::V2::UsersDoc < Docs::V2::Base
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

  api :PATCH, '/users/:id', 'Update an existing user'
  param :id, :number, required: true
  param :name, String
  param :interests, Array, of: String
  def update; end

  api :POST, '/users/:id/follow', 'Follow a user (applied to logged in user)', deprecated: true
  def follow; end

  api :POST, '/users/:id/unfollow', 'Unfollow a user (applied to logged in user)', deprecated: true
  def unfollow; end
end
