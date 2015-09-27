require_relative 'config/environment'

require 'seo_app/warden'

$stdout.sync = true
enable :logging, :dump_errors, :raise_errors

run SeoApp::Application
