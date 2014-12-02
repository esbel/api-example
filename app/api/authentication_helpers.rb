module AuthenticationHelpers
  # partly based on
  #   http://funonrails.com/2014/03/api-authentication-using-devise-token/
  def warden
    env["warden"]
  end

  def authenticated
    return true if warden.authenticated?
    params["access_token"] &&
      @user = User.find_by_authentication_token(params["access_token"])
  end

  def current_user
    warden.user || @user
  end

  def unauthorized!
    unauthorized_response = {
      "message" => "Not authorized.",
      "status"  => 401,
    }
    error!(unauthorized_response, 401)
  end
end
