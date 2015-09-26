SeoApp.configure do |config|
  # Postgress config
  config.db_host = 'localhost'
  config.db_port = '5432'
  config.db_name = 'sinatra'
  config.db_user = 'ruby'
  config.db_password = 'noway'

  config.db_url = 'postgres://ruby:noway@localhost/sinatra'

  config.adapter = 'sequel'
end
