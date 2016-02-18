class PostsController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :get_posts, only: [:create, :destroy]
  before_action :get_user, only: [:create, :destroy]

  def show
  end

  def new
  end

  def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to current_user }
        format.js
      else
        flash[:error] = 'Post cannot be created.'
        format.html { redirect_to current_user }
      end
    end
  end

  def destroy
    respond_to do |format|
      @post = Post.find(params[:id])
      @post.destroy
      format.html { redirect_to current_user }
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:post_text)
  end

  # Before filters
  def correct_user
    @micropost = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end

  # Methods for successful remote:true rendering
  def get_posts
    @posts = current_user.posts
  end

  def get_user
    @user = current_user
  end
end