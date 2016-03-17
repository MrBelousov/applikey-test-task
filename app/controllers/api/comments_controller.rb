class Api::CommentsController < Api::APIController
  def show
    render json: CommentSerializer.new(Comment.find(params[:id])).to_json
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
      render json: CommentSerializer.new(@comment).to_json
    else
      render json: @comment.errors
    end
  end
end
