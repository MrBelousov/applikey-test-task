class Api::APIController < ApplicationController
  include SessionsHelper

  before_action :restrict_access

  # Disabling CSRF token for mobile applications
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  respond_to :json

  rescue_from ActiveRecord::RecordNotFound do
    response_error error_message: 'Not found', status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    response_error error_message: exception.message
  end

  rescue_from ActionController::ParameterMissing do |exception|
    response_error error_message: exception.message
  end

  def response_error(options = {})
    options[:status] ||= :bad_request
    render_response(options)
  end

  def response_ok(options = {})
    options[:status] ||= :ok

    render_response(options)
  end

  def render_response(options = {})
    json = {}

    json[:status]             = options[:status]
    json[:status_code]        = Rack::Utils::SYMBOL_TO_STATUS_CODE[options[:status]]
    json[:payload]            = options[:payload]           if options[:payload]
    json[:errors]             = options[:errors]            if options[:errors]
    json[:error_code]         = options[:error_code]        if options[:error_code]
    json[:error_description]  = options[:error_description] if options[:error_description]

    if options[:error_message]
      if json[:errors].nil?
        json[:errors] = [options[:error_message]]
      elsif json[:errors].is_a?(Hash)
        json[:errors][:error] ||= []
        json[:errors][:error] << options[:error_message]
      end
    end

    if json[:payload] && options[:convert_object] != false
      json[:payload] = convert_object_to_json(json[:payload])
    end

    json.reverse_merge!(options[:plain]) if options[:plain]

    render json: json, status: options[:status]
  end

  private

  helper_method :current_user
  def current_user
    @current_user ||= User.includes(:api_keys).where(api_keys: { token: request.headers['Authorization'] }).first
  end

# Checking Api_key before actions
  def restrict_access
    if !current_user.nil? && current_user.api_keys.find_by_token(request.headers['Authorization']).valid?
      current_user.api_keys.each do |key|
        key.touch(:updated_at)
      end
    else
      render json: { message: 'Invalid API Token', error_code: 401 }, status: 401
    end
  end

  def restrict_access_by_header
    return true if @api_key
    @api_key = ApiKey.find_by_token(request.headers['Authorization'])
  end
end

