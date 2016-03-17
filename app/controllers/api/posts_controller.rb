class Api::PostsController < Api::APIController
  def index
    render json: ActiveModel::ArraySerializer.new(
            Post.all,
            each_serializer: PostSerializer
        )
  end

  def show
    render json: PostSerializer.new(Post.find(params[:id])).to_json
  end

  def create
    @post = @current_user.posts.new(post_params)
    if @post.save
      render json: PostSerializer.new(@post).to_json
    else
      render json: { errors: @post.errors }
    end
  end

  def update
    @post = @current_user.posts.find(params[:id])
    if @post.update(post_params)
      render json: PostSerializer.new(@post).to_json
    else
      render json: { errors: @post.errors }
    end
  end

  def destroy
    @post = @current_user.posts.find(params[:id])
    @post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:post_text)
  end
end