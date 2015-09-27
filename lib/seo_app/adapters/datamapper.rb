require 'pg'
require 'data_mapper'

module SeoApp
  module Adapters
    # Base storage interface
    class DMAdapter
      def initialize
        _config = SeoApp.configuration
        @conn = _config.db_url ? DataMapper.setup(:default, _config.db_url) : connect_with_creds
        require_relative 'dm_models'
        @conn.finalize
        @reports = SeoApp::DMModels::Report
        @links = SeoApp::DMModels::Link
        @headers = SeoApp::DMModels::Header
      end

      def all_reports
        @reports.all
      end

      def report(_key)
        # _report = @reports[_key]
        # _result = { report: _report, links: _report.links_dataset.all,
        #             headers: _report.headers_dataset.all }
        # SeoApp::Generator.to_html(_result)
      end

      def save_report(_opts)
        # @conn.transaction do
        #   _report = @reports.create(url: _opts[:url].to_s, created_at: _opts[:date],
        #                             links_count: _opts[:links].count,
        #                             remote_ip: _opts[:geo]['ip'],
        #                             country: _opts[:geo]['country_name'])

        #   save_links(_report, _opts[:links])
        #   save_headers(_report, _opts[:headers])
        # end
      end

      def save_links(_report, _links)
        # _links.each do |link|
        #   _link = @links.create(name: link[:name], href: link[:url],
        #                         rel: link[:rel], target: link[:target])
        #   _report.add_link(_link)
        # end
      end

      def save_headers(_report, _headers)
        # _headers.each do |k, v|
        #   _header = @headers.create(name: k, value: v)
        #   _report.add_header(_header)
        # end
      end

      def connect_with_creds
        _config = SeoApp.configuration
        DataMapper.setup(host: _config.db_host,
                         port: _config.db_port,
                         dbname: _config.db_name,
                         user: _config.db_user,
                         password: _config.db_password)
      end
    end
  end
end
