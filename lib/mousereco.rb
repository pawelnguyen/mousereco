require 'rails'
require 'haml'
require 'mousereco/engine'
require 'mousereco/visit_collection'

module Mousereco
  mattr_accessor :http_auth_user_name
  mattr_accessor :http_auth_password

  def self.setup
    yield self
  end
end
