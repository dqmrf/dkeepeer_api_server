class Api::TasksController < ApiController
  before_action :doorkeeper_authorize!
  before_action :set_task, only: [:show, :update, :destroy]

  def index
    @tasks = current_user.tasks
    if @tasks.present?
      render
    else
      render json: { message: 'No Tasks Found' }, status: 200
    end
    # render json: @tasks, status: :ok
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      render :show
    else
      render json: {
        message: 'Validation Failed',
        errors: @task.errors.full_messages
      }, status: 422
    end
  end
  # def create
  #   @task = current_resource_owner.tasks.create(task_params)
  #   render json: @task, status: :created if @task.save
  # end

  def show
  end

  def update
    if @task.update(task_params)
      render
    else
      render json: {
        message: 'Validation Failed',
        errors: @task.errors.full_messages
      }, status: 422
    end
  end

  def destroy
    if @task.destroy
      render
    else
      render json: {
        message: 'Validation Failed',
        errors: @task.errors.full_messages
      }, status: 422
    end
  end


  private

    def task_params
      params.require(:task).permit(:title)
    end

    def set_task
      @task = current_user.tasks.find(params[:id])
    end

end
