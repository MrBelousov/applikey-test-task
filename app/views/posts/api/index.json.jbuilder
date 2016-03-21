json.posts Post.all.page(params[:page]) do |post|
  json.post_text post.post_text
  json.user post.user, :id, :name, :email, :avatar
  json.comments post.comments do |comment|
    json.text comment.text
  end
end