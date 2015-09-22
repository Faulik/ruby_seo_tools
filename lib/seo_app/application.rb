require 'sinatra'
require 'sinatra/param'

require_relative 'link_parser'
require_relative 'storages/storage'

module SeoApp
  # Main routes
  class Application < ::Sinatra::Application
    # Configuration
    set :public_folder, -> { SeoApp.root_path.join('public').to_s }
    set :views, -> { SeoApp.root_path.join('views').to_s }
    set :static, true
    set :bind, '0.0.0.0'

    # Helpers
    helpers Sinatra::Param

    # Middleware
    use Rack::CommonLogger
    use Rack::Reloader

    get '/' do
      param :error, String

      @reports = SeoApp::Storage.all_reports
      @error = params[:error] ? params[:error] : nil

      slim :index
    end

    get '/reports/:key' do
      param :key, String

      SeoApp::Storage.report(params['key']) || redirect('/?error=NotFound')
    end

    post '/links' do
      param :url, String, required: true

      @link = LinkParser.new(params[:url])

      redirect '/?error=NonValidURL' unless @link.parse!
      redirect '/'
    end
  end
end
