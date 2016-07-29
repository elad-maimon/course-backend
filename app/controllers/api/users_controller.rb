class API::UsersController < API::APIController
  skip_before_action :validate_authentication, only: :create

  def index
    respond_with User.all, each_serializer: UserShortSerializer
  end

  def show
    respond_with User.find params[:id]
  end

  def create
    user = User.create user_params
    respond_with user, location: nil
  end

  def follow
    render json: 'follow'
  end

  def unfollow
    render json: 'unfollow'
  end

  private

  def user_params
    params.permit :name, :email, :password
  end
end
