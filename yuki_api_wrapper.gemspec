# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yuki_api_wrapper/version'

Gem::Specification.new do |spec|
  spec.name          = "yuki_api_wrapper"
  spec.version       = YukiApiWrapper::VERSION
  spec.authors       = ["Laurens Nutma"]
  spec.email         = ["laurensnutma@gmail.com"]
  spec.summary       = %q{Gem handling the Yuki API on}
  #spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  # Testing
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"


  spec.add_dependency "httparty"
  spec.add_dependency "libxml-ruby"
  spec.add_dependency "json"
  spec.add_dependency "mime-types"
  spec.add_dependency 'activesupport'


end
