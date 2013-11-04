# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'decamp/version'

Gem::Specification.new do |spec|
  spec.name          = "decamp"
  spec.version       = Decamp::VERSION
  spec.authors       = ["robhurring"]
  spec.email         = ["robhurring@gmail.com"]
  spec.description   = %q{Decamp route scraper}
  spec.summary       = %q{Scrape decamp bus routes}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "~> 1.6.0"
  spec.add_dependency "httparty", "~> 0.11.0"

  spec.add_development_dependency "bundler", "~> 1.3"
end
