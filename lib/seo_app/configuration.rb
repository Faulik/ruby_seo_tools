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
    attr_reader :adapter

    # Files Storage
    attr_accessor :reports_folder

    # Db configuration
    attr_accessor :db_url
    attr_accessor :db_host
    attr_accessor :db_port
    attr_accessor :db_name
    attr_accessor :db_user
    attr_accessor :db_password

    def initialize
      @reports_folder = '/public/reports/'
    end

    def adapter=(_type)
      case _type
      when 'puresql'
        SeoApp::Storage.database = SeoApp::Adapters::PureSql.new
        @adapter = 'puresql'
      when 'sequel'
        SeoApp::Storage.database = SeoApp::Adapters::SeqAdapter.new
        @adapter = 'sequel'
      when 'datamapper'
        SeoApp::Storage.database = SeoApp::Adapters::DMAdapter.new
        @adapter = 'datamapper'
      else
        SeoApp::Storage.database = SeoApp::Adapters::Files.new
        @adapter = 'files'
      end
    end
  end
end
