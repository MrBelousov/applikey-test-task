json.user do
  json.partial! 'api/users/users', user: @user
end