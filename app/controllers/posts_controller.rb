class PostsController < ApplicationController
  def show
  end

  def new
  end

  def create
    @posts = current_user.posts.page(params[:page])
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
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:succes] = 'Your post was successfully updated!'
      redirect_to user_path(current_user)
    else
      flash.now[:error] = 'Post cannot be updated.'
      render 'edit'
    end
  end

  def destroy
    @posts = current_user.posts.page(params[:page])
    @post = Post.find(params[:id])
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
end