class ApplicationController < ActionController::Base
  before_action :user_signed_in?, only: [:create, :edit, :update, :destroy]
  #before_action :correct_user, only: [:edit, :update, :destroy]

  include SessionsHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  helper_method :current_user
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end
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
end
