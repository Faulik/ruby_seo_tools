# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ['Faul']
  gem.email         = ['faullik@gmail.com']
  gem.description   = 'Seo app for seo stuff'
  gem.summary       = 'Make reports'
  gem.homepage      = 'https://github.com/Faulik/ruby_seo_tools'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = ['seo_app']
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'seo_app'
  gem.require_paths = ['lib']
  gem.version       = '0.0.1'

  gem.add_runtime_dependency 'httparty', ['=> 0.13.5']
  gem.add_runtime_dependency 'nokogiri', ['=> 1.6.7.rc3']
  gem.add_runtime_dependency 'geoip', ['=> 1.6.1']
  gem.add_runtime_dependency 'slim', ['=> 3.0.6']
end
