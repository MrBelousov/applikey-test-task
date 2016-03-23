class Api::CommentsController < Api::APIController
  before_action :get_commentable!, only: [:create]

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def get_commentable!
    raise NotImplementedError, 'Comment format not implemented!'
  end
end
