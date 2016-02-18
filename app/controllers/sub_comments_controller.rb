class SubCommentsController < ApplicationController
  before_action :user_signed_in?, only: [:create, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def show
  end

  def new
  end

  def create
    @sub_comment = SubComment.new(sub_comment_params)
    @sub_comment.user = current_user
    @sub_comment.post_comment = PostComment.find(params[:comment_id])
    @comment = PostComment.find(params[:comment_id])
    respond_to do |format|
      if @sub_comment.save
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
      @sub_comment = SubComment.find(params[:id])
      @comment = @sub_comment.post_comment
      @sub_comment.destroy
      format.html { redirect_to :back }
      format.js
    end
  end

  private

  def sub_comment_params
    params.require(:sub_comment).permit(:comment_text)
  end

  # Before filters
  def correct_user
    @sub_comment = current_user.sub_comments.find_by(id: params[:id])
    redirect_to root_url if @sub_comment.nil?
  end
end
