Doorkeeper.configure do
  orm :active_record

  resource_owner_authenticator do
    # fail "Please configure doorkeeper resource_owner_authenticator block located in #{__FILE__}"
  end

  resource_owner_from_credentials do |routes|
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password]) && user.email_confirmed
      user
    end
  end

  default_scopes :public
  optional_scopes :write

  grant_flows ['password', 'client_credentials']

  access_token_expires_in nil
end
