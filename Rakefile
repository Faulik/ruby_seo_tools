require 'rubygems'
require 'bundler/setup'
# require 'rspec/core/rake_task'

task default: :test

task :environment do
  require_relative 'config/environment'
end

Dir.glob('lib/tasks/*.rake').each { |r| import r }
