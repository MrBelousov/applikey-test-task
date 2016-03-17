class Api::Posts::CommentsController < Api::CommentsController
  def create
    @comment = Post.find(params[:post_id]).comments.build(comment_params)
    create_comment
  end
end
