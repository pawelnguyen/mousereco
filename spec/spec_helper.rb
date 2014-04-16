ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'fabrication'

Dir[File.dirname(__FILE__) + '/support/*.rb'].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

Fabrication.configure do |config|
  config.fabricator_path = '../fabricators'
end

RSpec.configure do |config|
  config.include AuthHelper
  config.include TimeHelper

  config.use_transactional_fixtures = true

  config.infer_base_class_for_anonymous_controllers = false

  config.order = "random"

  config.render_views
end
