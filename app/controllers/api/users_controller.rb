class API::UsersController < API::APIController
  skip_before_action :validate_authentication, only: :create
  before_action :set_user, only: [:show, :follow, :unfollow]

  def index
    respond_with User.all, each_serializer: UserShortSerializer
  end

  def show
    respond_with @user
  end

  def create
    user = User.create user_params
    respond_with user, location: nil
  end

  def follow
    current_user.follow @user.id
    respond_with @user, location: nil
  rescue ActiveRecord::RecordNotUnique
    raise ApiParameterException.new.add_error :id, 'already following'
  end

  def unfollow
    current_user.unfollow @user.id
    respond_with @user, location: nil
  rescue ActiveRecord::RecordNotFound
    raise ApiParameterException.new.add_error :id, 'not following yet'
  end

  private

  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.permit :name, :email, :password
  end
end
