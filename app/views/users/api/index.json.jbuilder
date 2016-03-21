json.users User.all.page(params[:page]) do |user|
  json.id user.id
  json.name user.name
  json.posts user.posts do |post|
    json.id post.id
    json.post_text post.post_text
  end
  json.comments user.comments do |comment|
    json.id comment.id
    json.text comment.text
    json.commentable_type comment.commentable_type
    json.commentable_id comment.commentable_id
  end
end