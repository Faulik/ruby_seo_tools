
builder = Rack::Builder.new do
  Warden::Manager.serialize_into_session { |user| user.id }
  Warden::Manager.serialize_from_session { |id| SeoApp::SequelModels::User[id] }
  
  Warden::Manager.before_failure do |env, _|
    env['REQUEST_METHOD'] = 'POST'
  end

  Warden::Strategies.add(:password) do
    def valid?
      params['user'] && params['user']['name'] && params['user']['password']
    end

    def authenticate!
      user = SeoApp::SequelModels::User.authenticate(params['user']['name'],
                                                     params['user']['password'])
      user.nil? ? fail!('Could not log in') : success!(user, 'Successfully logged in')
    end
  end

  use Rack::MethodOverride
  use Rack::Session::Cookie, :secret => 'goturbo111'
  use Warden::Manager do |config|
    config.scope_defaults :default,
                          strategies: [:password],
                          action: '/unauthenticated'
    config.failure_app = SeoApp::Application
  end

  run SeoApp::Application
end

Rack::Handler::Thin.run builder
