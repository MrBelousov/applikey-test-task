class Posts::CommentsController < CommentsController
  def get_commentable!
    @commentable = Post.find(params[:post_id])
  end
end
