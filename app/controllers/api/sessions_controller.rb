class API::SessionsController < API::APIController
  skip_before_action :validate_authentication
  before_action :validate_session_params, only: :create

  # TODO: use only token for login (only long term cookie, no session)
  def create
    user = User.find_by email: params[:email].downcase
    if user && user.authenticate(params[:password])
      log_in user
      head :created
    else
      head :unauthorized
    end
  end

  def destroy
    log_out if logged_in?
    head :no_content
  end

  private

  def validate_session_params
    exception = ApiParameterException.new
    exception.add_missing :email if params[:email].blank?
    exception.add_missing :password if params[:password].blank?
    raise exception if exception.has_errors?
  end
end
