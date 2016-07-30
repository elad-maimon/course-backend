class API::V2::UsersController < API::APIController
  skip_before_action :validate_authentication, only: :create
  before_action :set_user, only: [:show, :update]
  before_action :validate_current_user, only: [:update]

  def index
    respond_with User.all, each_serializer: ::V2::UserShortSerializer
  end

  def show
    respond_with @user, respond_options
  end

  def create
    user = User.create user_params
    respond_with user, respond_options
  end

  def update
    @user.update user_params
    respond_with @user
  end

  private

  def params_user_id
    params[:id]
  end

  def user_params
    if action_name == 'create'
      params.permit :name, :email, :password
    else
      params.permit :name, :interests
    end
  end

  def respond_options
    { serializer: ::V2::UserSerializer, location: nil }
  end
end
