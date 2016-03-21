json.id @post.id
json.post_text @post.post_text
json.user @post.user, :id, :name, :email
json.comments @post.comments do |comment|
  json.text comment.text
end
