class Api::PostsController < Api::APIController
  before_action :set_current_user_post!, only: [:update, :destroy]

  def index
    render 'posts/api/index'
  end

  def show
    @post = Post.find(params[:id])
    render 'posts/api/show'
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      render 'posts/api/show'
    else
      render json: { errors: @post.errors }
    end
  end

  def update
    if @post.update(post_params)
      render 'posts/api/show'
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

  def set_current_user_post!
    @post = current_user.posts.find(params[:id])
  end
end