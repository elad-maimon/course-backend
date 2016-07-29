class API::PostsController < API::APIController
  before_action :require_permission, only: [:create, :update, :destroy]
  before_action :set_user
  before_action :set_post, only: [:show, :update, :destroy, :like, :unlike]

  def index
    respond_with @user.posts, each_serializer: PostShortSerializer
  end

  def show
    respond_with @post
  end

  def create
    @post = @user.posts.create post_params
    respond_with @post, location: nil
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
    respond_with @post, location: nil
  rescue ActiveRecord::RecordNotUnique
    raise ApiParameterException.new.add_error :id, 'already liked'
  end

  def unlike
    @post.unlike_by current_user.id
    respond_with @post, location: nil
  rescue ActiveRecord::RecordNotFound
    raise ApiParameterException.new.add_error :id, 'not liked yet'
  end

  private

  def require_permission
    if current_user.id.to_s != params[:user_id]
      head :forbidden
    end
  end

  def set_user
    @user = User.find params[:user_id]
  end

  def set_post
    @post = @user.posts.find params[:id]
  end

  def post_params
    params.permit :content
  end
end
