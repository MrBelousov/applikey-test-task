class Api::Comments::CommentsController < Api::CommentsController
  def create
    commentable Comment.find(params[:comment_id])
  end
end
