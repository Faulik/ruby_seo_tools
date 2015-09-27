require 'sinatra'
require 'sinatra/param'
require 'warden'

require_relative 'link_parser'
require_relative 'storage'
require_relative 'generator'

module SeoApp
  # Main routes
  class Application < ::Sinatra::Application
    # Configuration
    set :session_secret, 'goturbo111'
    set :public_folder, -> { SeoApp.root_path.join('public').to_s }
    set :views, -> { SeoApp.root_path.join('views').to_s }
    set :static, true
    set :bind, '0.0.0.0'
    enable :sessions

    # Helpers
    helpers Sinatra::Param

    # Middleware
    use Rack::CommonLogger
    use Rack::Reloader

    get '/' do
      param :error, String

      redirect '/login' unless env['warden'].authenticated?
      @reports = SeoApp::Storage.all_reports
      @error = params[:error] ? params[:error] : nil
      @user = env['warden'].user
      slim :index
    end

    get '/login' do
      redirect '/' if env['warden'].authenticated?
      @error = session['error_message'] ? session['error_message'] : nil
      session['error_message'] = nil

      slim :login
    end

    post '/login' do
      param :user['name'], String, reqired: true
      param :user['password'], String, reqired: true

      env['warden'].authenticate!
      redirect '/'
    end

    post '/unauthenticated/?' do

      session['error_message'] = env['warden.options'][:message]
      status 401
      redirect '/'
    end

    delete '/login' do
      env['warden'].raw_session.inspect
      env['warden'].logout
      redirect '/'
    end

    get '/register' do
      slim :register
    end

    post '/register' do
      param :user['name'], String, reqired: true
      param :user['password'], String, reqired: true

      SeoApp::SequelModels::User.add_user(name: params['user'][:name],
                                          password: params['user'][:password],
                                          ip: request.ip)
      redirect '/login'
    end

    get '/reports/:key' do
      param :key, String

      redirect '/login' unless env['warden'].authenticated?
      SeoApp::Storage.report(params['key']) || redirect('/?error=NotFound')
    end

    post '/links' do
      param :url, String, required: true

      redirect '/login' unless env['warden'].authenticated?
      @link = LinkParser.new(params[:url])

      redirect '/?error=NonValidURL' unless @link.parse!
      redirect '/'
    end

    not_found do
      redirect '/'
    end
  end
end
