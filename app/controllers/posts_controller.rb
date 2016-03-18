class PostsController < ApplicationController
  before_action :set_current_user_post, only: [:edit, :update, :destroy]

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

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    if @post.update(post_params)
      flash[:succes] = 'Your post was successfully updated!'
      redirect_to user_path(current_user)
    else
      flash.now[:error] = 'Post cannot be updated.'
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:post_text)
  end

  def set_current_user_post
    @post = current_user.posts.find(params[:id])
  end
end