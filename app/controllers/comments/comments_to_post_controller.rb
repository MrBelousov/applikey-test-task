class CommentsToPostController < CommentsController
  before_action :user_signed_in?, only: :create
  before_action :get_post, only: :create

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to :back }
        #format.js
      else
        flash[:error] = 'Comment cannot be created.'
        format.html { redirect_to :back }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def get_post
    @post = Post.find(params[:post_id]) if params[:post_id]
  end
end
