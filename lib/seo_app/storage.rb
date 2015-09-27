
require_relative 'adapters/sequel'
# require_relative 'adapters/files'
# require_relative 'adapters/puresql'
# require_relative 'adapters/datamapper'

module SeoApp
  # Storage interface
  class Storage
    class << self; attr_accessor :database end

    ##
    ## @brief      Returns all report's name, date and key's to look for each
    ##
    ## @return    {
    ##             site_url: String,
    ##             date: String
    ##             key: String
    ##            }
    ##
    def self.all_reports
      database.all_reports
    end

    ##
    ## @brief      Retrieve report for key
    ##
    ## @param      _key  Key for retrieval
    ##
    ## @return     html formatted report
    ##
    def self.report(_key)
      database.report(_key)
    end

    def self.save_report(_options)
      database.save_report(_options)
    end
  end

  # Base storage interface
  class AbstractStorage
    def all_reports; end

    def report(_key); end

    def save_report(_options); end
  end
end
