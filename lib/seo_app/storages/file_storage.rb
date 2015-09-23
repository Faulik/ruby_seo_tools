require 'pathname'

module SeoApp
  # Base storage interface
  class FileStorage
    attr_accessor :reports_path

    def initialize
      _path = SeoApp.configuration.reports_folder || ''
      # BUG! some wild problem with normal SeoApp.root_path.join(_path)
      @reports_path = File.join(SeoApp.root_path, _path)
    end

    def all_reports
      _reports = []

      Dir.foreach(@reports_path) do |file|
        next unless File.extname(file) == '.html'
        parts = file.gsub('.html', '').split('__')
        _reports << { site_url: parts[0],
                      date: parts[1].tr('_', ' '),
                      key: file
                    }
      end
      _reports
    end

    def report(_key)
      return nil unless File.exist?(@reports_path.join(_key))
      File.open(@reports_path.join(_key), 'r')
    end

    def save_report(_html, _options)
      _name = generate_file_name(_options[:url], _options[:date])
      
      File.open(@reports_path.join(_name), 'w') do |f|
        f.write(_html)
      end
    end

    def generate_file_name(url, date)
      "#{url.host}__#{date}.html"
    end
  end
end
