class Api::UsersController < ApiController
  before_action :find_user, only: [:show, :update, :destroy]

  def index
    @users = User.all

    if @users.count(:all) > 0
      render
    else
      render json: { message: 'No Users Found' }, status: 200
    end
  end

  def show
    render
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :ok
    else
      render json: {
        message: 'Validation Failed',
        errors: @user.errors.full_messages
      }, status: 422
    end
  end

  def update
    if @user.update(user_params)
      render :show
    else
      render json: {
        message: 'Validation Failed',
        errors: @user.errors.full_messages
      }, status: 422
    end
  end

  def destroy
    if @user.destroy
      render
    else
      render json: {
        message: 'Validation Failed',
        errors: @user.errors.full_messages
      }, status: 422
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
    end

    def find_user
      @user = User.find(params[:id])
    end
  
end
