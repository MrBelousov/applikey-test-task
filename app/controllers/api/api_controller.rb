class Api::APIController < ApplicationController
  include SessionsHelper

  before_action :restrict_access

# Disabling CSRF token for mobile applications
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  private

# Checking Api_key before actions
  def restrict_access
    unless restrict_access_by_header
      render json: { message: 'Invalid API Token', error_code: 401 }, status: 401
      return
    end
    @current_api_user = @api_key.user if @api_key
  end

  def restrict_access_by_header
    return true if @api_key

    @api_key = ApiKey.find_by_token(request.headers['Authorization'])
  end
end

