require File.expand_path('../lib/opener/pos_tagger/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name                  = 'opener-pos-tagger'
  gem.version               = Opener::POSTagger::VERSION
  gem.authors               = ['development@olery.com']
  gem.summary               = 'Gem that wraps up the different existing pos-taggers'
  gem.description           = gem.summary
  gem.homepage              = 'http://opener-project.github.com/'
  gem.has_rdoc              = "yard"
  gem.required_ruby_version = ">= 1.9.2"

  gem.files       = `git ls-files`.split("\n")
  gem.executables = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files  = gem.files.grep(%r{^(test|spec|features)/})

  gem.add_dependency 'opener-pos-tagger-base'
  gem.add_dependency 'opener-pos-tagger-en-es'
  gem.add_dependency 'opener-pos-tagger-fr'
  gem.add_dependency 'opener-pos-tagger-it'

  gem.add_dependency 'nokogiri'
  gem.add_dependency 'builder', '~>3.1'
  gem.add_dependency 'sinatra', '~>1.4.2'
  gem.add_dependency 'httpclient'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'cucumber'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rake'
end

