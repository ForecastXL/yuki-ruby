# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yuki/version'

Gem::Specification.new do |spec|
  spec.name          = 'yuki-ruby'
  spec.version       = Yuki::VERSION
  spec.authors       = ['ForecastXL']
  spec.email         = ['developers@forecastxl.com']
  spec.summary       = 'Ruby wrapper for the Yuki API'
  spec.homepage      = 'https://www.forecastxl.com'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty'
  spec.add_dependency 'libxml-ruby'
  spec.add_dependency 'json'
  spec.add_dependency 'mime-types'
  spec.add_dependency 'activesupport'

  # Testing
  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
end