$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

require_relative 'boot'

ENV['RACK_ENV'] ||= 'development'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, ENV['RACK_ENV']) if defined?(Bundler)

require 'seo_app'

if ENV['OPENSHIFT_APP_NAME']
  require_relative 'environments/openshift'
elsif ENV['HEROKU']
  require_relative 'environments/heroku'
else
  configure(:development) { require_relative 'environments/app' }
end

Dir["#{File.dirname(__FILE__)}/initializers/*.rb"].sort.each do |path|
  require File.expand_path("../initializers/#{File.basename(path, '.rb')}", __FILE__)
end
