class Posts::CommentsController < CommentsController
  before_action :commentable
end
