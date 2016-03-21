class Api::Posts::CommentsController < Api::CommentsController
  def create
    commentable Post.find(params[:post_id])
  end
end
