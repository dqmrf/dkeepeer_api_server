json.users @users do |user|
  json.id             user.id

  json.created_at     user.created_at
  json.updated_at     user.updated_at
end