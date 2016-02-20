class PostCommentsController < ApplicationController
  before_action :user_signed_in?, only: [:create, :edit, :update, :destroy]
  before_action :correct_user, only: [:destroy, :edit, :update]
  before_action :get_post, only: [:create]
  before_action :get_all_posts, only: [:destroy]

  def show
  end

  def new
  end

  def create
    @comment = @post.post_comments.new(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to :back }
        format.js
      else
        flash[:error] = 'Comment cannot be created.'
        format.html { redirect_to :back }
      end
    end
  end

  def destroy
    respond_to do |format|
      @comment = PostComment.find(params[:id])
      @post = @comment.post
      @comment.destroy
      format.html { redirect_to :back }
      format.js
    end
  end

  private

  def comment_params
    params.require(:post_comment).permit(:comment_text)
  end

  # Before filters
  def correct_user
    redirect_to root_url unless current_user.post_comments.exists?(id: params[:id])
  end

  def get_post
    @post = Post.find(params[:post_id])
  end

  def get_all_posts
    @posts = Post.all
  end
end
