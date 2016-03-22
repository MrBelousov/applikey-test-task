class Api::Posts::CommentsController < Api::CommentsController
  def get_commentable!
    @commentable = Post.find(params[:post_id])
  end
end
