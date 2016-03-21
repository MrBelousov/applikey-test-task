json.id @comment.id
json.text @comment.text
json.commentable_type @comment.commentable_type
json.commentable_id @comment.commentable_id
json.user @comment.user, :id, :name, :email
json.comments @comment.comments do |comment|
  json.text comment.text
end