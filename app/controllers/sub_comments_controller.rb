class SubCommentsController < ApplicationController
  before_action :user_signed_in?, only: [:create, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :get_comment, only: [:create]

  def show
  end

  def new
  end

  def create
    @sub_comment = @comment.sub_comments.new(sub_comment_params)
    @sub_comment.user = current_user
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
    redirect_to root_url unless current_user.sub_comments.exists?(id: params[:id])
  end

  def get_comment
    @comment = PostComment.find(params[:comment_id])
  end
end
