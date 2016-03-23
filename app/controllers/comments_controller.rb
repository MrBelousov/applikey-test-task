class CommentsController < ApplicationController
  before_action :get_commentable!, only: [:create]

  def show
  end

  def new
  end

  def create
    @comment = @commentable.comments.build(comment_params)
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
    @comment = current_user.comments.find(params[:id])
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

  def get_commentable!
    raise NotImplementedError, 'Comment format not implemented!'
  end
end
