require 'httparty'
require 'nokogiri'
require 'slim'
require 'uri'
require 'geoip'

# Links parsing parts of app
module SeoApp
  #
  class LinkParser
    attr_reader :links, :headers, :date, :geo, :url

    def initialize(url)
      @url = URI.parse(url)
      @links = []
      @headers = []
      @geo = {}
      @date = Time.now.to_i
    end

    def parse!
      return false unless check_url

      begin
        _response = HTTParty.get @url
      rescue
        return false
      end

      procces_response _response
    end

    def procces_response(response)
      @headers = response.headers
      @geo = retrieve_geo_params
      gather_links! response.body

      SeoApp::Storage.save_report(url: @url, date: @date, links: @links,
                                  headers: @headers, geo: @geo)
    end

    def gather_links!(body)
      ::Nokogiri::HTML(body).css('a').each do |link|
        @links << {
          name: link.text || 'None',
          href: link['url'] || 'None',
          rel: link['rel'] || 'None',
          target: link['target'] || 'None'
        }
      end
    end

    def retrieve_geo_params
      GeoIP.new(SeoApp.root_path.join('db/GeoLiteCity.dat')).city(@url.host.to_s)
    end

    def check_url
      @url = !@url.scheme ? URI.parse('http://' + @url.to_s) : @url
      @url.is_a?(URI::HTTP) ? true : false
    end

    def self.say_hello
      puts 'Hello'
    end
  end
end
