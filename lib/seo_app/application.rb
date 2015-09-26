require 'sinatra'
require 'sinatra/param'

require_relative 'link_parser'
require_relative 'storage'
require_relative 'generator'

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
    enable :sessions
    use Rack::CommonLogger
    use Rack::Reloader

    get '/' do
      param :error, String

      @reports = SeoApp::Storage.all_reports
      @error = params[:error] ? params[:error] : nil
      slim :index
    end

    get '/login' do
      slim :login
    end

    post '/login' do
      param :username, String, reqired: true
      param :password, String, reqired: true

      @username = params[:username]
      @password = params[:password]
    end

    post '/register' do
      param :username, String, reqired: true
      param :password, String, reqired: true

      @username = params[:username]
      @password = params[:password]
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
