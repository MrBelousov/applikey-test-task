class Api::Comments::CommentsController < Api::CommentsController
  def create
    @comment = Comment.find(params[:comment_id]).comments.build(comment_params)
    create_comment
  end
end
