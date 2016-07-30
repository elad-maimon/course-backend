require 'api_parameter_exception'

class API::APIController < ApplicationController
  include SessionsHelper

  respond_to :json

  skip_before_action :verify_authenticity_token
  before_action :validate_authentication
  # TODO: validate json format and return 406

  rescue_from ActionController::ParameterMissing, with: :respond_to_parameter_missing
  rescue_from ActiveRecord::RecordNotFound, with: :respond_to_not_found
  rescue_from ::ApiParameterException, with: :respond_to_api_parameter_exception

  protected

  def params_user_id
    params[:user_id]
  end

  def set_user
    @user = User.find params_user_id
  end

  def validate_current_user
    head :forbidden if current_user.id.to_s != params_user_id
  end

  def validate_authentication
    head :unauthorized unless logged_in?
  end

  def respond_to_not_found(exception)
    render json: exception.message, status: :not_found
  end

  def respond_to_parameter_missing(exception)
    errors = { exception.param.to_sym => "can't be blank" }
    render_unprocessable_entity errors
  end

  def respond_to_api_parameter_exception(exception)
    render_unprocessable_entity exception.errors
  end

  def render_unprocessable_entity(errors)
    render json: { errors: errors }, status: :unprocessable_entity
  end
end
