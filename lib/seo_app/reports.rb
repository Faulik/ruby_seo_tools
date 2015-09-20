
# Opperations with existing reports
module SeoApp
  def self.check_reports(path)
    _reports = []

    Dir.foreach(path) do |file|
      next if file == '.' || file == '..' || file == '.gitignore'
      parts = file.gsub('.html', '').split('__')
      _reports << { site_url: parts[0],
                    date: parts[1].gsub('_', ' '),
                    file_name: file }
    end
    _reports
  end
end
