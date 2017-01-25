class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

    def doorkeeper_unauthorized_render_options(error: nil)
      { json: { error: "Not authorized" } }
    end

    def current_resource_owner
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    def current_user
      @current_user = User.find(session[:user_id]) if session[:user_id]
    end

    helper_method :current_user
end
