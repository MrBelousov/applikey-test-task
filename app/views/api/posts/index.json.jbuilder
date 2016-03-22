json.posts @posts do |post|
  json.partial! 'api/posts/posts', post: post
end
