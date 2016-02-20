class HomeController < ApplicationController
  def index
    @posts = Post.limit(10)
  end

  def help
  end
end
