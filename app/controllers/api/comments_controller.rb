class Api::CommentsController < Api::APIController
  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  protected

  def create_comment
    @comment.user = current_user
    if @comment.save
      render 'comments/api/show'
    else
      render json: @comment.errors
    end
  end

  def commentable(object)
    @comment = object.comments.build(comment_params)
    create_comment
  end
end
