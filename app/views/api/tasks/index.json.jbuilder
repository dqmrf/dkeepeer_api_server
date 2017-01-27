json.tasks @tasks do |task|
  json.id             task.id
  json.title          task.title

  json.created_at     task.created_at
  json.updated_at     task.updated_at

  json.user_id        task.user_id
end
