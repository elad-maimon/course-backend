class Docs::V2::PostsDoc < Docs::V2::Base
  resource_description do
    resource_id 'Posts'
  end

  api :GET, '/users/:user_id/posts', "List a user's posts"
  param :user_id, :number, required: true
  def index; end

  api :GET, '/users/:user_id/posts/:id', "Show a user's post"
  param :user_id, :number, required: true
  param :id, :number, required: true
  def show; end

  api :POST, '/users/:user_id/posts', 'Create a new post'
  param :user_id, :number, required: true, desc: 'Must be the authenticated user'
  param :content, String
  def create; end

  api :PATCH, '/users/:user_id/posts/:id', 'Update an existing post'
  param :user_id, :number, required: true, desc: 'Must be the authenticated user'
  param :id, :number, required: true
  param :content, String
  def update; end

  api :DELETE, '/users/:user_id/posts/:id', 'Delete an existing post'
  param :user_id, :number, required: true, desc: 'Must be the authenticated user'
  param :id, :number, required: true
  def destroy; end

  api :POST, '/users/:user_id/posts/:id/like', 'Like a post (applied to logged in user)'
  param :user_id, :number, required: true
  param :id, :number, required: true
  def like; end

  api :POST, '/users/:user_id/posts/:id/unlike', 'Unlike a post (applied to logged in user)'
  param :user_id, :number, required: true
  param :id, :number, required: true
  def unlike; end
end
