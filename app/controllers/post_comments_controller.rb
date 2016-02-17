class PostCommentsController < ApplicationController
  before_action :user_signed_in?, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def show
  end

  def new
  end

  def create
    @comment = PostComment.new(comment_params)
    @comment.user = current_user
    @comment.post = Post.find(params[:post_id])
    @post = Post.find(params[:post_id])
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
    @comment = current_user.post_comments.find_by(id: params[:id])
    redirect_to root_url if @comment.nil?
  end
end
