SeoApp.configure do |config|
  # Postgress config
  env = URI.parse(ENV['DATABASE_URL'])
  config.db_host = env.host
  config.db_port = env.port
  config.db_name = env.dbname
  config.db_user = env.user
  config.db_password = env.password

  config.database_type = 'postgres'
end
