
namespace :db do
  desc 'Run migrations'
  task migrate: [:environment] do |_, args|
    require 'sequel'
    Sequel.extension :migration
    db = Sequel.connect(SeoApp.configuration.db_url)
    if args[:version]
      puts 'Migrating to version #{args[:version]}'
      Sequel::Migrator.run(db, 'db/migrations', target: args[:version].to_i)
    else
      puts 'Migrating to latest'
      Sequel::Migrator.run(db, 'db/migrations')
    end
  end
end
