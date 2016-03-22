class Api::Comments::CommentsController < Api::CommentsController
  def get_commentable!
    @commentable = Comment.find(params[:comment_id])
  end
end
