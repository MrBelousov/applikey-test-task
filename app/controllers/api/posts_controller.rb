class Api::PostsController < Api::APIController
  before_action :set_current_user_post, only: [:update, :destroy]
  def index
    render json: ActiveModel::ArraySerializer.new(
            Post.all.page(params[:page]),
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
    if @post.update(post_params)
      render json: PostSerializer.new(@post).to_json
    else
      render json: { errors: @post.errors }
    end
  end

  def destroy
    @post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:post_text)
  end

  def set_current_user_post
    @post = @current_user.posts.find(params[:id])
  end
end