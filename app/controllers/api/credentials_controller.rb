class Api::CredentialsController < ApiController
  before_action :doorkeeper_authorize!
  respond_to    :json

  def me
    respond_with current_user
  end
end