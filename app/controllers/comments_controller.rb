class CommentsController < ApplicationController
    before_action :user_signed_in?, only: [:create, :edit, :update, :destroy]
    before_action :correct_user, only: [:destroy, :edit, :update]
    before_action :get_post, only: [:create]
    #before_action :commentable_type, only: [:create]

    def show
    end

    def new
    end

    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end

    private

    def commentable_type
      @comment = if !params[:comment_id].nil?
                   Comment.find(params[:comment_id]).comments.build(comment_params)
                  elsif !params[:post_id].nil?
                    @comment = @post.comments.build(comment_params)
                  end
    end

    def comment_params
      params.require(:comment).permit(:text)
    end

    # Before filters
    def correct_user
      current_user.comments.find_by(commentable_id: params[:id])
    end

    def get_post
      @post = Post.find(params[:post_id]) if params[:post_id]
    end
end
