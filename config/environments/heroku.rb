SeoApp.configure do |config|
  # Postgress config
  env = URI.parse(ENV['DATABASE_URL'])
  config.db_url = env

  config.database_type = 'postgres'
end
