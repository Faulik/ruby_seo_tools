require 'sinatra'
require 'sinatra/param'

require_relative 'link_parser.rb'

module SeoApp
  # Main routes
  class Application < ::Sinatra::Application
    # Configuration
    set :public_folder, -> { SeoApp.root_path.join('public').to_s }
    set :views, -> { SeoApp.root_path.join('views').to_s }
    set :static, true

    # Helpers
    helpers Sinatra::Param

    # Middleware
    use Rack::CommonLogger
    use Rack::Reloader

    get '/' do
      slim :index
    end

    post '/links' do
      param :url, String, required: true

      @link = LinkParser.new(params[:url])
      @link.parse!

      slim :index
    end
  end
end
