# Config class
module SeoApp
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  # Main confoguration class for app
  class Configuration
    attr_reader :database

    # Files Storage
    attr_accessor :reports_folder

    # Db configuration
    attr_accessor :db_host
    attr_accessor :db_port
    attr_accessor :db_name
    attr_accessor :db_user
    attr_accessor :db_password

    def initialize
      @reports_folder = '/public/reports/'
    end

    def database_type=(_type)
      puts 'lollo'
      case _type
      when 'postgres'
        SeoApp::Storage.database = SeoApp::PgStorage.new
        @database_type = 'postgres'
      when 'files'
        SeoApp::Storage.database = SeoApp::FileStorage.new
        @database_type = 'files'
      end

    end
  end
end
