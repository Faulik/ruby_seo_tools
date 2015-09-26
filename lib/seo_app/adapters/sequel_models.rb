module SeoApp
  module SequelModels
    class Report < Sequel::Model(:reports)
      one_to_many :headers
      one_to_many :links
    end

    class Header < Sequel::Model(:headers)
      many_to_one :report
    end

    class Link < Sequel::Model(:links)
      many_to_one :report
    end
  end
end