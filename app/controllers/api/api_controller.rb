class Api::APIController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :restrict_access, only: [:create, :update, :destroy]

  # Disabling CSRF token for mobile applications
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  protected

  def json_request?
    request.format.json?
  end
end