class Api::APIController < ApplicationController
  before_action :restrict_access, only: [:create, :update, :destroy]

  # Disabling CSRF token for mobile applications
  protect_from_forgery
  skip_before_action :verify_authenticity_token

  def create_user_from_api_response(response)
    @user = User.new(email: response[:email], name: response[:name])
    if @user.save
      render json: @user
    end
  end

  private

  # Checking Api_key before actions
  def restrict_access
    unless restrict_access_by_params || restrict_access_by_header
      render json: { message: 'Invalid API Token', error_code: 401 }, status: 401
      return
    end
    @current_user = @api_key.user if @api_key
  end

  def restrict_access_by_header
    return true if @api_key

    authenticate_with_http_token do |token|
      @api_key = ApiKey.find_by_token(token)
    end
  end

  def restrict_access_by_params
    return true if @api_key

    @api_key = ApiKey.find_by_token(params[:token])
  end
end