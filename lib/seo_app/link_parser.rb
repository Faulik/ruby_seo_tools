require 'httparty'
require 'nokogiri'

# Links parsing parts of app
module SeoApp
  #
  class LinkParser
    attr_reader :items

    def initialize(url)
      @url = url
      @items = []
    end

    # Load and parse link
    def parse!
      _response = HTTParty.get(@url)
      ::Nokogiri::HTML(_response.body).xpath('a').each do |link|
        @items << {
          name: link.text,
          url: link.url,
          rel: link.rel,
          target: link.target
        }
      end
      puts @items 
      # TODO: parse links
    end
  end
end
