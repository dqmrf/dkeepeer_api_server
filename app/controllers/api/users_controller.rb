class Api::UsersController < ApplicationController
  before_action -> { doorkeeper_authorize! :public }, only: :show
  before_action -> { doorkeeper_authorize! :write }, only: :update

  def new
    @user = User.new
    render json: @user
  end

  def show
    render json: current_resource_owner.as_json
  end

  def update
    render json: { result: current_resource_owner.touch(:updated_at) }
  end
  
end
