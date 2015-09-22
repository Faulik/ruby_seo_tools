require 'pathname'

require 'seo_app/configuration'
require 'seo_app/application'

# Config module
module SeoApp
  # SeoApp.root_path.join('..')
  #
  def self.root_path
    @root_path ||= Pathname.new(File.dirname(File.expand_path('../', __FILE__)))
  end
end
