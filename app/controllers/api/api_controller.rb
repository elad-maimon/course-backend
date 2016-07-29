require 'api_parameter_exception'

class API::APIController < ApplicationController
  include SessionsHelper

  respond_to :json

  before_action :validate_authentication
  skip_before_action :verify_authenticity_token
  # TODO: validate json format and return 406

  rescue_from ActionController::ParameterMissing, with: :respond_to_parameter_missing
  rescue_from ActiveRecord::RecordNotFound, with: :respond_to_not_found
  rescue_from ::ApiParameterException, with: :respond_to_api_parameter_exception


  protected

  def validate_authentication
    head :unauthorized unless logged_in?
  end

  # def default_serializer_options
  #   { root: false }
  # end

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
