SeoApp.configure do |config|
  # Postgress config
  config.db_url = ENV['DATABASE_URL']

  config.database_type = 'postgres'
end
