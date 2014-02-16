module Mousereco
  class ApplicationController < ActionController::Base
    http_basic_authenticate_with name: Mousereco.http_auth_user_name, password: Mousereco.http_auth_password

    layout 'mousereco/application'
  end
end
