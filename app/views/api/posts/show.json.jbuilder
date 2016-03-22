json.post do
  json.partial! 'api/posts/posts', post: @post
end
