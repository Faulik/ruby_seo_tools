require 'pg'
require 'pry-byebug'

module SeoApp
  attr_accessor :table
  # Base storage interface
  class PgStorage
    def initialize
      @table = 'html_files'
      SeoApp.configuration.db_url ? connect_with_url : connect_with_creds
      create_table if check_table[0]['count'] == '0'
    end

    def all_reports
      _reports = []
      @conn.exec("SELECT * from #{@table}") do |result|
        result.each do |row|
          _reports << { site_url: row['url'],
                        date: row['date'].tr('_', ' '),
                        key: row['id']
                      }
        end
      end
      _reports
    end

    def report(_key)
      @conn.exec("SELECT html from #{@table} where id = #{_key}")[0]['html']
    end

    def save_report(_html, _options)
      @conn.exec("INSERT INTO #{@table} 
                  (
                    url,
                    date,
                    html
                  ) values (
                  '#{_options[:url].to_s}',
                  '#{_options[:date]}',
                  '#{_html}'
                  )")
    end

    def check_table
      @conn.exec("SELECT count(*) from information_schema.tables
                  where table_name = '#{@table}'")
    end

    def create_table
      @conn.exec("CREATE table #{@table} 
                  (
                    url text NOT NULL,
                    date text NOT NULL,
                    id SERIAL,
                    html text NOT NULL,
                    CONSTRAINT id PRIMARY KEY (id)
                  ) WITH (
                    OIDS=FALSE
                  );")      
    end

    def connect_with_url
      @conn = PG.connect(SeoApp.configuration.db_url)
    end

    def connect_with_creds
      _config = SeoApp.configuration

      @conn = PG.connect(host: _config.db_host, 
                          port: _config.db_port, 
                          dbname: _config.db_name, 
                          user: _config.db_user, 
                          password: _config.db_password)
    end

    def disconnect
      @conn.close
    end
  end
end