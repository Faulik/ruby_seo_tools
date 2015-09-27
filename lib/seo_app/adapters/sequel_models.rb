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

    class User < Sequel::Model(:users)
      def self.authenticate(name, password)
        user = first(name: name)
        user if user && user.password == password
      end

      def self.add_user(_opts)
        create(name: _opts[:name],
               password: _opts[:password],
               ip: _opts[:ip])
      end
    end
  end
end
