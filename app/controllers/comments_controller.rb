class CommentsController < ApplicationController
  def show
  end

  def new
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
