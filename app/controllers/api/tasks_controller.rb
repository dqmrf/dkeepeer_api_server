class Api::TasksController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
    @tasks = current_resource_owner.tasks
    render json: @tasks, status: :ok
  end

  def create
    @task = current_resource_owner.tasks.create(task_params)
    render json: @task, status: :created if @task.save
  end

  private

    def task_params
      params.require(:task).permit(:title)
    end

end
