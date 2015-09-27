module SeoApp
  module DMModels
    class Header
      include DataMapper::Resource
      belongs_to :report

      property :id,        Serial
      property :name,      String
      property :value,     String
      property :report_id, Integer
    end

    class Link
      include DataMapper::Resource
      belongs_to :report

      property :id,        Serial
      property :name,      String
      property :href,      String
      property :rel,       String
      property :target,    String
      property :report_id, Integer
    end

    class Report
      include DataMapper::Resource
      has n, :links
      han n, :headers

      property :id,          Serial
      property :url,         String
      property :created_at,  Integer
      property :links_count, Integer
      property :remote_ip,   IPAddress
      property :country,     String
    end
  end
end
