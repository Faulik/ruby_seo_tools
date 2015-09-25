SeoApp.configure do |config|
  # Postgress config
  config.db_url = ENV['OPENSHIFT_POSTGRESQL_DB_URL']

  config.database_type = 'postgres'
end
