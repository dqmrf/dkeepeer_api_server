class Api::TasksController < ApiController
  before_action :doorkeeper_authorize!
  before_action :set_task, only: [:show, :update, :destroy]

  def index
    @tasks = current_user.tasks.order(updated_at: :desc)
    if @tasks.present?
      render
    else
      render json: { message: 'No tasks found' }, status: 204
    end
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      render :show
    else
      render json: {
        message: 'Creating failed',
        errors: @task.errors.full_messages
      }, status: 422
    end
  end

  def show
    unless @task
      render json: {
        message: 'Can\'t load task',
        errors: @task.errors.full_messages
      }, status: 204 
    end
  end

  def update
    if @task.update(task_params)
      render
    else
      render json: {
        message: 'Updating failed',
        errors: @task.errors.full_messages
      }, status: 422
    end
  end

  def destroy
    if @task.destroy
      render
    else
      render json: {
        message: 'Destroying failed',
        errors: @task.errors.full_messages
      }, status: 422
    end
  end

  def batch_destroy
    @ids = params[:tasks]
    
    if @ids && @ids.kind_of?(Array)
      @tasks = current_user.tasks.where(id: @ids)
      if @tasks.delete_all
        render 
      else
        render json: {
          message: 'Destroying failed.',
          errors: @task.errors.full_messages
        }, status: 500
      end
    else
      render json: {
        message: 'Invalid params.'
      }, status: 422
    end
  end

  private

    def task_params
      params.require(:task).permit(:title, :description, :priority, :due_date, :completed, :user_id)
    end

    def set_task
      @task = current_user.tasks.find(params[:id])
    end

end
