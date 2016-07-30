class API::V1::UsersController < API::APIController
  skip_before_action :validate_authentication, only: :create
  before_action :set_user, only: [:show, :follow, :unfollow]

  def index
    respond_with User.all, each_serializer: ::V1::UserShortSerializer
  end

  def show
    respond_with @user, respond_options
  end

  def create
    user = User.create user_params
    respond_with user, respond_options
  end

  def follow
    current_user.follow @user.id
    respond_with @user, respond_options
  rescue ActiveRecord::RecordNotUnique
    raise ApiParameterException.new.add_error :id, 'already following'
  end

  def unfollow
    current_user.unfollow @user.id
    respond_with @user, respond_options
  rescue ActiveRecord::RecordNotFound
    raise ApiParameterException.new.add_error :id, 'not following yet'
  end

  private

  def params_user_id
    params[:id]
  end

  def user_params
    params.permit :name, :email, :password
  end

  def respond_options
    { serializer: ::V1::UserSerializer, location: nil }
  end
end
