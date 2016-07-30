class API::V1::PostsController < API::APIController
  before_action :set_user
  before_action :validate_current_user, only: [:create, :update, :destroy]
  before_action :set_post, only: [:show, :update, :destroy, :like, :unlike]

  def index
    respond_with @user.posts, each_serializer: ::V1::PostShortSerializer
  end

  def show
    respond_with @post, respond_options
  end

  def create
    @post = @user.posts.create post_params
    respond_with @post, respond_options
  end

  def update
    @post.update post_params
    respond_with @post
  end

  def destroy
    @post.destroy
    respond_with @post
  end

  def like
    @post.like_by current_user.id
    respond_with @post, respond_options
  rescue ActiveRecord::RecordNotUnique
    raise ApiParameterException.new.add_error :id, 'already liked'
  end

  def unlike
    @post.unlike_by current_user.id
    respond_with @post, respond_options
  rescue ActiveRecord::RecordNotFound
    raise ApiParameterException.new.add_error :id, 'not liked yet'
  end

  private

  def set_post
    @post = @user.posts.find params[:id]
  end

  def post_params
    params.permit :content
  end

  def respond_options
    { serializer: ::V1::PostSerializer, location: nil }
  end
end
