SeoApp.configure do |config|
  # Postgress config
  config.db_host = ENV['DATABASE_URL']
  config.db_port = '5432'
  config.db_name = 'd9972ipr26em8d'

  config.database_type = 'files'
end
