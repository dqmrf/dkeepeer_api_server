json.id               @task.id
json.title            @task.title
json.description      @task.description
json.priority         @task.priority
json.due_date         @task.due_date
json.completed        @task.completed
json.user_email       @task.user.email
json.user_email       @task.user.email
json.user_first_name  @task.user.first_name
json.user_last_name   @task.user.last_name
json.user_full_name   @task.user.full_name

json.created_at       @task.created_at
json.updated_at       @task.updated_at

json.user_id          @task.user_id
