class API::PostsController < API::APIController
  before_action :require_permission, only: [:create, :update, :destroy]
  before_action :set_user
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    respond_with @user.posts
  end

  def show
    respond_with @post
  end

  def create
    @post = @user.posts.create post_params
    respond_with @post
  end

  def update
    @post.update post_params
    respond_with @post
  end

  def destroy
    @post.destroy
    respond_with @post
  end

  private

  def require_permission
    # if current_user != params[:user_id]
    if '1' != params[:user_id]
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
