Warden::Strategies.add(:password) do
  def valid?
    params['user'] && params['user']['name'] && params['user']['password']
  end

  def authenticate!
    user = SeoApp::SequelModels::User.authenticate(params['user']['name'],
                                                   params['user']['password'])
    if user.nil?
      throw(:warden, message: 'Could not login with this credentials')
    else
      success!(user, 'Successfully logged in')
    end
  end
end

Warden::Manager.before_failure do |env, _|
  env['REQUEST_METHOD'] = 'POST'
end

use Rack::MethodOverride
use Rack::Session::Cookie, secret: 'goturbo111'
use Warden::Manager do |config|
  config.serialize_into_session { |user| user.id }
  config.serialize_from_session { |id| SeoApp::SequelModels::User[id] }

  config.scope_defaults :default,
                        strategies: [:password],
                        action: '/unauthenticated'
  config.failure_app = SeoApp::Application
end
