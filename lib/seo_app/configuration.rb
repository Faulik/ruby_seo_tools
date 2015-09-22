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
    attr_accessor :host
    attr_accessor :port
    attr_accessor :database_name
    attr_accessor :user
    attr_accessor :password

    def initialize
      @reports_folder = '/public/reports/'
    end

    def database=(_type)
      case _type
      when 'postgres'
        SeoApp::Storage.database = SeoApp::PgStorage.new
      when 'files'
        SeoApp::Storage.database = SeoApp::FileStorage.new
      end
    end
  end
end
