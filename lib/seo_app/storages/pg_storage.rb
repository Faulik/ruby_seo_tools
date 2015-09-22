module SeoApp
  # Base storage interface
  class PgStorage
    def initialize
    end

    def all_reports
    end

    def report(_key)
    end

    def save_report(_data, _name)
    end
  end
end