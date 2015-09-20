# Configure Rack Envinronment
ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require File.expand_path('../../config/environment', __FILE__)

RSpec.configure do |config|
  # Remove this line if you don't want RSpec's should and should_not
  # methods or matchers
  require 'rspec/expectations'
  config.include RSpec::Matchers

  require 'rack/test'
  config.include Rack::Test::Methods

  # == Mock Framework
  config.mock_with :rspec
end
