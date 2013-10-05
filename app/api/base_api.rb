require 'grape'

class BaseAPI < Grape::API
  format :json
  default_format :json

  before do
    header['Access-Control-Allow-Origin'] = '*'
    header['Access-Control-Request-Method'] = '*'
  end

  mount EventsApi
end