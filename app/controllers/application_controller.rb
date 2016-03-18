class ApplicationController < ActionController::Base
  before_action :user_signed_in?, only: [:create, :edit, :update, :destroy]
  #before_action :correct_user, only: [:edit, :update, :destroy]

  include SessionsHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

=begin
  def correct_user
    case params[:controller]
      when 'comments'
        current_user.comments.find_by(commentable_id: params[:id])
      when 'posts'
        current_user.posts.find(params[:id])
      when 'users'
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
      else
        fail ArgumentError
    end
  end
=end

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
