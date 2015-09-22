SeoApp.configure do |config|
  # Postgress config
  config.host = ENV['DATABASE_URL']
  config.port = '5432'
  config.database_name = 'd9972ipr26em8d'

  config.database = 'files'
end
