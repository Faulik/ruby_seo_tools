SeoApp.configure do |config|
  # Postgress config
  config.db_url = ENV['DATABASE_URL']

  config.adapter = 'sequel'
end
