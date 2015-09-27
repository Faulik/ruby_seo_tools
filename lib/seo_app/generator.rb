require 'slim'

module SeoApp
  # Generate report for things
  class Generator
    def self.to_html(params)
      _report = Slim::Template.new('views/reports.slim').render(Object.new, params)
      Slim::Template.new('views/layout.slim').render { _report }
    end
  end
end
