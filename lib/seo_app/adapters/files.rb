require 'pathname'

module SeoApp
  module Adapters
    # File storage interface
    class Files
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
          _reports << { url: parts[0],
                        created_at: parts[1],
                        id: file
                      }
        end
        
        _reports
      end

      def report(_key)
        return nil unless File.exist?(@reports_path.join(_key))
        File.open(@reports_path.join(_key), 'r')
      end

      def save_report(_opts)
        _name = generate_file_name(_opts[:url], _opts[:date])

        _report = make_report(_opts)

        _result = { report: _report, links: _opts[:links],
                    headers: convert_hash_to_array(_opts[:headers]) }

        File.open(@reports_path.join(_name), 'w') do |f|
          f.write(SeoApp::Generator.to_html(_result))
        end
      end

      def make_report(_opts)
        { url: _opts[:url].to_s, created_at: _opts[:date],
          links_count: _opts[:links].count,
          remote_ip: _opts[:geo]['ip'],
          country: _opts[:geo]['country_name'] }
      end

      def convert_hash_to_array(_hash)
        _array = []
        _hash.each_pair do |k, v|
          _array << { name: k, value: v }
        end
        _array
      end

      def generate_file_name(_url, _date)
        "#{_url.host}__#{_date}.html"
      end
    end
  end
end
