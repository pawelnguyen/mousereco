module AuthHelper
  def http_login
    user_name = Mousereco.http_auth_user_name
    password = Mousereco.http_auth_password
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user_name, password)
  end
end