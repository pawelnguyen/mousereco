ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

Fabrication.configure do |config|
  config.fabricator_path = '../fabricators'
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true

  config.infer_base_class_for_anonymous_controllers = false

  config.order = "random"
end
